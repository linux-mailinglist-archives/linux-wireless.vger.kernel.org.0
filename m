Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34179E401
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjIMJoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjIMJoQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:44:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FE2199E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=anQMUCBEGRmKJTumv/SkUzXirwoCr4bcRocp5IkaDFc=;
        t=1694598252; x=1695807852; b=k3MeXwNyZ4ZBHekZc9MsK5+veBithUEK05UrDbV7oGNCCZH
        kqw3UARj4FfpMhdsJ9vRxvriFlUOIP3TZaBPL5wg3Qbnb4gg7FN9ljpZKgZPw+t3ysNoyoVYbRQ2Q
        vrMvW8B5v3/ncsTgusUrvFyVOh+TaBa2cA+7MhDTiQXqJmlbgNSmRmcpf7/hVH1aMlge0sMiGAoC3
        N4zqTt348uMCSU7QgKk5CnmYu4Wipq9Nq/aMpbIHgcpuL/PZFQHArdGxo+9wmwntnWIV9/UsPMjny
        IxRMvXpj1bD6CxVFy57LtfwLvZHQSwrbKudMrsVF8TPzE0T9FhGCX10Vky51FsVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgMPp-00EkRI-1s;
        Wed, 13 Sep 2023 11:44:09 +0200
Message-ID: <5a98910aa4577e784e17ef6e0201dc57b11a5c24.camel@sipsolutions.net>
Subject: Re: [PATCH v6 2/3] wifi: mac80211: allow userspace to enable driver
 control of MU-EDCA
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Sep 2023 11:44:08 +0200
In-Reply-To: <1682960363-15452-2-git-send-email-quic_msinada@quicinc.com>
References: <1682960363-15452-1-git-send-email-quic_msinada@quicinc.com>
         <1682960363-15452-2-git-send-email-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -376,6 +376,7 @@ enum ieee80211_bss_change {
>  	BSS_CHANGED_FILS_DISCOVERY      =3D 1<<30,
>  	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP =3D 1<<31,
>  	BSS_CHANGED_EHT_PUNCTURING	=3D BIT_ULL(32),
> +	BSS_CHANGED_DYNAMIC_MU_EDCA	=3D BIT_ULL(33),

This is missing documentation.

> + * @dyn_muedca_enabled: whether to enable or disable driver control of M=
U-EDCA
> + *	parameters. If set to zero, driver dynamically updating parameters is
> + *	disabled; if set to 1, driver dynamically updating parameters is enab=
le
>   */
>  struct ieee80211_bss_conf {
>  	struct ieee80211_vif *vif;
> @@ -776,6 +780,8 @@ struct ieee80211_bss_conf {
>  	bool eht_su_beamformer;
>  	bool eht_su_beamformee;
>  	bool eht_mu_beamformer;
> +
> +	int dyn_muedca_enabled;

why int with 0/1 rather than bool like the others?

> @@ -1465,6 +1465,11 @@ static int ieee80211_start_ap(struct wiphy *wiphy,=
 struct net_device *dev,
>  		changed |=3D BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
>  	}
> =20
> +	if (link_conf->dyn_muedca_enabled !=3D params->dyn_muedca_enable) {
> +		link_conf->dyn_muedca_enabled =3D params->dyn_muedca_enable;
> +		changed |=3D BSS_CHANGED_DYNAMIC_MU_EDCA;
> +	}

This doesn't seem right ... think about it.

johannes

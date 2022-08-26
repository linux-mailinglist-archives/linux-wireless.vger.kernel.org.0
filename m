Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B045A22BC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiHZIPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 04:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245046AbiHZIPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 04:15:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2C9D2741
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 01:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FzQydZyQvf8YDKX5d02dhvU1T6g0uwZIjVcqB6wxKTE=;
        t=1661501747; x=1662711347; b=PpXUmWFpONlCVe67bdjxvDkMaNIkYFH5N5m7QY3mZ5kueAl
        qP97l98bi1ulQw7mThJmAt19NvNw9Ot6Yw/sOvRhD3H8K9iueMSH+e8samAOzwkb2lYaosf6uSHJU
        pwfi3wbRLNgwsCqcHioR+MeYL+AWPZIdApBgLdsP2KSeNg//0UXhFtC2OgvQ1Y4j3nmNfO9U+Snsd
        KdPvEQHA82v5BSrp7vPTzTJcoCoz8L809GFiYmxpGOCwT+4iK63WA/asG1PZU9yMp700iZZjTxAPj
        SBDs/x6kfJQ9Gj7BRKLbLsGzQW0w6DJuS2nFwbTamshYurEC4M3c2+dfuSw2lv9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRUVF-000A6e-0e;
        Fri, 26 Aug 2022 10:15:45 +0200
Message-ID: <a93126420f23f6f019b0b17849e0847f176c4b87.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] mac80211: Add VHT MU-MIMO related flags in
 ieee80211_bss_conf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Aug 2022 10:15:44 +0200
In-Reply-To: <1660286767-11853-1-git-send-email-quic_msinada@quicinc.com>
References: <1660286767-11853-1-git-send-email-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-08-11 at 23:46 -0700, Muna Sinada wrote:
>=20
> + * @vht_su_beamformer: does this BSS support operation as an VHT SU beam=
former
> + * @vht_su_beamformee: does this BSS support operation as an VHT SU beam=
formee
> + * @vht_mu_beamformer: does this BSS support operation as an VHT MU beam=
former
> + * @vht_mu_beamformee: does this BSS support operation as an VHT MU beam=
formee


Should probably say that you meant this only for AP mode?

Though why not fill it also in client mode?

>  	link_conf->beacon_int =3D params->beacon_interval;

You rebased on a multi-link tree ...

> +	if (params->vht_cap) {
> +		sdata->vif.bss_conf.vht_su_beamformer =3D


but still used vif.bss_conf :)

Please respin with MLO support.

johannes

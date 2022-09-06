Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BCF5AE61C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiIFLAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiIFK7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 06:59:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A41FCF6
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AEt6dak7DlQb3h77P6IKD4vTeEGyltI0RPT4tsssfDg=;
        t=1662461986; x=1663671586; b=Lyy97lMdXZotG3ns7HQN4t4nb498WZCK6GS/8JVsxCo3Ml3
        w535mJpw3ZaEUuwSpxOSfmw3FwovRzz4v5SciTOgb9zN9kwuzbm5rcO3aKgJ8FZ3+Wjj9nJ0PjRKr
        w7Trp1JQA0kfu5hizDq3u9c8a5m222GILkLZJj7zNzKvqycmJtoyvUZw2R2iXVjU5ZfRgTcwWlMRH
        V9R30uW3q0vSv6Q6g7a6RWvYMqJozNgA0/m6Oelf6mrRrQDgWkZjV0e59jgKzCo0o3zBnQ9xkrun+
        z6RWSUHI2FICYEV012ydNNJFX79VY62zDAI+9zfFRkcRH344iF4C4IyqoUL6/u4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVWIv-009PGh-0c;
        Tue, 06 Sep 2022 12:59:41 +0200
Message-ID: <c6a0171e47046633518bffc58cd15542a883165a.camel@sipsolutions.net>
Subject: Re: [PATCH 2/7] mac80211: rework on 6 GHz power type definition
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 06 Sep 2022 12:59:40 +0200
In-Reply-To: <20220704102341.5692-3-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
         <20220704102341.5692-3-quic_adisi@quicinc.com>
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

On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>=20
> +++ b/include/linux/ieee80211.h
> @@ -2132,18 +2132,17 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vh=
t_cap *cap,
>  /**
>   * enum ieee80211_ap_reg_power - regulatory power for a Access Point
>   *
> - * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
>   * @IEEE80211_REG_LPI: Indoor Access Point
>   * @IEEE80211_REG_SP: Standard power Access Point
>   * @IEEE80211_REG_VLP: Very low power Access Point
>=20

So these other values *do* come from the spec? Otherwise I think we
should move them somewhere else (e.g. cfg80211.h)

johannes

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA005B58B7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiILKt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILKtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 06:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4018431368
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 03:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE23160B52
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 10:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F494C433C1;
        Mon, 12 Sep 2022 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662979763;
        bh=GWmpLkDHOamaH18vVPfnc4F1h0ku9hgrS00WmUIaHd4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GPVtZWPLpQyDW4JdxgKheDA/6H0tLlD3sgTpsGiB86JH1V3s/jgdInhvAyxwBm3zL
         OHtnci26mAAwfIUJ9Ieg8e8OZ/2H45cPPxF2XfndumxboewD0SrWxZiDMveVSOYZ4P
         C7p/3r10nxBx08og1c4kbpZ04pLF69KbHuXfBcOGFl9TMHILGkUxn2lpO0en8AJjGw
         aH1dkqCg6AimMfBjE68452nevXfiEan1qjj5FgP1yCxC3GHKFXhUG9qIFlKxoNQzZQ
         YQen1gq4TAG4Azu3Zs504nyYb+ODryhA8KwVtfMUniPbkTrj5Wp0PPisV+yCYLDD5M
         wN8mXuntltKuA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
Subject: Re: [PATCH] wifi: mac80211: RCU-ify link STA pointers
In-Reply-To: <24df3a0c-a312-d9b6-5840-1eacd79d824b@quicinc.com> (Wen Gong's
        message of "Mon, 12 Sep 2022 17:36:47 +0800")
References: <24df3a0c-a312-d9b6-5840-1eacd79d824b@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 12 Sep 2022 13:49:19 +0300
Message-ID: <87a67498b4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Hi Johannes,
>
> Currently for MLO test, the others links's rx_nss of struct
> ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
> becaue they are not pass into ieee80211_sta_set_rx_nss() in
> mac80211 except the deflink which means the primary link.
> This lead driver get nss =3D 0 for other links. Will you fix it
> or is it design by default?
>
> Only primary link has valid rx_nss value which is not 0 by below call sta=
ck.
> ieee80211_assoc_success()->
> =C2=A0=C2=A0=C2=A0 rate_control_rate_init(sta);
>
> commit:c71420db653aba30a234d1e4cf86dde376e604fa
> wifi: mac80211: RCU-ify link STA pointers

Strange format and s-o-b missing. Was this meant as an RFC patch?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

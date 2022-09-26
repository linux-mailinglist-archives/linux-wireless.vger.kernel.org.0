Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2465E9B56
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiIZH66 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiIZH62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 03:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B3D63C6
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 00:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5286F61889
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 07:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22A6C433C1;
        Mon, 26 Sep 2022 07:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178878;
        bh=3vdqkKP+qds42Ot02GNxi1bWCUHaFRACwUX0EGN0beU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nHgnHQZrfxajqt/kfXj2ein3cWxKhoQv+Yyt0MmeJh/JpueFmf09OfzGDWsW+XNIT
         W+sSHe7qtMVk2qxFr4kyrmz9ApTtqxgmRj8969b2DzrpFXOjg3PdFpjMf1lBesUpLO
         Pp3xiyWoRCzS+5yT0YgHme1Dyy/GdVBn9126OOjv3Yj3rnOSYG4PjmpIi2EaLzBOdm
         6MsKS2nflxFmAxyQFSddaNP/YAcXCTNDHXucCpziBpUS3IkgG3BkFS0NQUJLTjnk4i
         K508on0beBxAThLS5KekW0kiJhV3cPEJSY2gWLhg2VtTxBEAPEs5ZcW7zh36I8D4u/
         s8f4QN3NmO0Iw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     "Lin Ian \(CSSITB CSS ICW SW WFS \/ EE\)" <ian.lin@infineon.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH 4/5] brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer
References: <20220914033620.12742-1-ian.lin@infineon.com>
        <20220914033620.12742-5-ian.lin@infineon.com>
        <87tu506mre.fsf@kernel.org>
        <d390462d-1cd2-fc3f-5b0c-bdcd332ed0bc@infineon.com>
        <ff7e72ae-0431-b568-32fc-7b1cbf250e20@quicinc.com>
Date:   Mon, 26 Sep 2022 10:54:33 +0300
In-Reply-To: <ff7e72ae-0431-b568-32fc-7b1cbf250e20@quicinc.com> (Jeff
        Johnson's message of "Fri, 23 Sep 2022 08:29:34 -0700")
Message-ID: <87czbi4ll2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>>>> @@ -3032,6 +3033,12 @@ static s32 brcmf_inform_single_bss(struct
>>>> brcmf_cfg80211_info *cfg,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 notify_ielen =3D le32_to_cpu(bi->=
ie_length);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss_data.signal =3D (s16)le16_to_=
cpu(bi->RSSI) * 100;
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ssid =3D brcmf_parse_tlvs(notify_ie, notify_=
ielen, WLAN_EID_SSID);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (ssid && ssid->data[0] =3D=3D '\0' && ssi=
d->len =3D=3D bi->SSID_len) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* Update SSID for hidden AP */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy((u8 *)ssid->data, bi->SSID, bi->SSID_len);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> memcpy() takes a void pointer so the cast is not needed.
>>
>> There should be a type casting since 'ssid' is a const pointer.
>> As you saw there will be build warning in PATCH v2 (sorry I didn't
>> notice that locally)
>> I will send PATCH v3 to restore type casting, is that ok?
>>
>
> writing through a const pointer seems broken.

Yeah, this is exactly why I don't like casting. I see so often casts
removing the const and that can lead to another problems.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

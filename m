Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1233325DF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 13:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCIMzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 07:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCIMyw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 07:54:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7418C06174A
        for <linux-wireless@vger.kernel.org>; Tue,  9 Mar 2021 04:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:
        Mime-Version:From:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZIyWVueiq8ZTFkLQnHVCn01WsV2t4MDHYuO0+m1su5c=; b=rjeaxY+nZZRnQtayscSQwVoF8N
        tTEuaqvLcjDrT+5nu3YZA0b2ZtBfDONrvsetsGVhb1XR2BVhlHeiIrUT6PR7spqJkfVahmEMybhxe
        nvnBSEZA1msfm2oIV9E16uiMGQ8GZ1mxn/iZVq3TLwHRoAtwTdNX3yt81VgF9UouEWFE=;
Received: from p200300daa71dfa007859633b625cf55e.dip0.t-ipconnect.de ([2003:da:a71d:fa00:7859:633b:625c:f55e])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lJbst-0003CN-Vg; Tue, 09 Mar 2021 13:54:48 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Felix Fietkau <nbd@nbd.name>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH wireless-drivers] mt76: mt7921: fix airtime reporting
Date:   Tue, 9 Mar 2021 13:54:43 +0100
Message-Id: <5CE99CC9-FA48-4F1E-AF73-72B5E7275C49@nbd.name>
References: <87wnugzkmn.fsf@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, leon.yen@mediatek.com
In-Reply-To: <87wnugzkmn.fsf@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: iPhone Mail (17F75)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On 9. Mar 2021, at 11:29, Kalle Valo <kvalo@codeaurora.org> wrote:
>=20
> =EF=BB=BFLorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
>> Fix {tx,rx}_airtime reporting for mt7921 driver. Wrong register definitio=
ns
>> trigger a tx hangs before resetting airtime stats.
>>=20
>> Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
>> Tested-by: Leon Yen <leon.yen@mediatek.com>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> I'll queue this to v5.12 and assigned to me on patchwork. Felix, ack?
Acked-by: Felix Fietkau <nbd@nbd.name>=


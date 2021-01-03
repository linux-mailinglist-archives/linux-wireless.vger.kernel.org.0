Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A32E8C0C
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 13:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbhACMBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jan 2021 07:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbhACMB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jan 2021 07:01:26 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64657C061573
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jan 2021 04:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3F4MjoXVKz97IMWrdfiTFch6WUbtC66BpQnXjqENIbg=; b=InSDWN1c9uBdMk7kpOr3p9kpSP
        wFRmHsLoRj+3riB/12XHEQkMNAuHA01wgpgC9eOGDQo2qG8I5kFv4WwT5fq1mMCaPFbv1V7zqMDs1
        C1w/N/BeB3l20uIMMdmCxMtmT8594W8AtCudfJ7FUTFf3TMUXZ5t9eksVH1jObT/melU=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kw23e-0001I0-IF; Sun, 03 Jan 2021 13:00:26 +0100
Subject: Re: [PATCH -next v4 01/13] mt76: mt7921: add module support
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <cover.1609347310.git.objelf@gmail.com>
 <6efa97c619a5d2d2030c3f0c0da8e8a19b107feb.1609347310.git.objelf@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <e807a9e2-656c-83b3-31c5-4ff87766df48@nbd.name>
Date:   Sun, 3 Jan 2021 13:00:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <6efa97c619a5d2d2030c3f0c0da8e8a19b107feb.1609347310.git.objelf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-30 19:06, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add mt7921 as the pci driver module.
> 
> The purpose of the patch is to check about if the following patches are
> able to compile properly.
> 
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
> Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
This should be the last patch in the series.

- Felix

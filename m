Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462A13B4E65
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Jun 2021 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhFZLpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Jun 2021 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFZLpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Jun 2021 07:45:01 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D14EC061574;
        Sat, 26 Jun 2021 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iD6UlxSttVDb7EnnXFsDzZvUfsf4FN2OlXfYInO/xiM=; b=QUKM7wPYxpTXhF4K113BV9uKig
        vy/mfLFlUvvZlUZLmvM19dnH0+1gb0UW8ezI/0ce2I6sNUA5RFeYh4Usc1NEsEANS4WukSF9GIz/5
        fRCDK2V4Pvya7C5EPD61oIH7snvK5BDGP9TiCXluv1LkP0RWcgV+G560x3a1SG6nhZTY=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lx6hk-0001tR-Ki; Sat, 26 Jun 2021 13:42:32 +0200
Subject: Re: [PATCH] mt76: mt7915: fix info leak in mt7915_mcu_set_pre_cal()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
References: <YNXvLvrvllpXgCIn@mwanda>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <cb2177fd-8e22-3286-c524-a727688a9ebe@nbd.name>
Date:   Sat, 26 Jun 2021 13:42:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNXvLvrvllpXgCIn@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-25 16:58, Dan Carpenter wrote:
> Zero out all the unused members of "req" so that we don't disclose
> stack information.
> 
> Fixes: 495184ac91bb ("mt76: mt7915: add support for applying pre-calibration data")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Felix Fietkau <nbd@nbd.name>

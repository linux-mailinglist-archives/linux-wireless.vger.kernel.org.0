Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E545432DA64
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 20:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhCDT3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 14:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhCDT3Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 14:29:24 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE2C061574
        for <linux-wireless@vger.kernel.org>; Thu,  4 Mar 2021 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7i8BEbXDXEOW8E286D5JURPRm2okvke1VJqD1R/Oop4=; b=oy/Fil/cXzLyBMkS+Zdzw/o5fK
        7sS5AzQoGZaDuDZ6D64Xygfw5oTGh4GSRWmF89/lfkxKv/F1hUPpmUGjWIztDX8GAWjzeXLXee6gL
        o7RhOqlgUOIWMeDKc9nTWMOeIigFxyBXH20skz2mOiAbT7lM/NTykEzfYmWUcubbcLJ8=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lHtdy-0003kA-JI; Thu, 04 Mar 2021 20:28:18 +0100
Subject: Re: [PATCH v4] mt76: mt7615: add missing capabilities for DBDC
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <0573b06759c90309b5a6a6e2b6b95796e7db60c7.1614843966.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <384dc2df-60d7-c6bf-040c-d8583af30a98@nbd.name>
Date:   Thu, 4 Mar 2021 20:28:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0573b06759c90309b5a6a6e2b6b95796e7db60c7.1614843966.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-03-04 09:55, Ryder Lee wrote:
> This improves performance for second phy.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>I actually prefer v1 of this patch. You can fix the init order issues by
simply dropping the if (phy->mt76->cap.has_*) checks, since they are not
needed at all.

- Felix

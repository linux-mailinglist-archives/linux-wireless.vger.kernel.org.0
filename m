Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6473A50A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 17:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjFVPbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjFVPbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 11:31:16 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A226A9
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6K5xry+aHFYubzOYUoPnWzVv5jG1R6DQhP/7vPLmktY=; b=s5RvVoLnr7Qx9yv/3sorpRmJqI
        a6jXyS7oYcfhnr1f8hUsOCFtzf1GPoEIxetzTqTjfQnd8+/+/qxVHdRRGOl0hDObekjqMDuN8JynX
        3Q/+5ekv8UnsyAij7XKI/2V2KWCWhNlLzb/oC2g7L3705ySo8+ZSHsL7ffL0uRmRDsvk=;
Received: from p4ff133b9.dip0.t-ipconnect.de ([79.241.51.185] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qCMFM-008tKW-3N; Thu, 22 Jun 2023 17:29:20 +0200
Message-ID: <954b5c26-9f98-a45d-605f-ea7a5072f2e1@nbd.name>
Date:   Thu, 22 Jun 2023 17:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 04/10] wifi: mt76: mt7996: init he and eht cap for
 AP_VLAN
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
References: <20230605152141.17434-1-shayne.chen@mediatek.com>
 <20230605152141.17434-4-shayne.chen@mediatek.com>
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20230605152141.17434-4-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.06.23 17:21, Shayne Chen wrote:
> From: Peter Chiu <chui-hao.chiu@mediatek.com>
> 
> Init he and eht capabilities for AP_VLAN type. Without this patch, the
> BA response from AP_VLAN will not include the ADDBA extension tag.
If that's the case, then I think this is something that needs to be 
fixed in mac80211 instead. Since interfaces with the AP_VLAN iftype are 
not exposed to the driver, I don't see why the driver should register 
capabilities for that type.

- Felix

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BF6C5847
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCVU6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCVU6j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 16:58:39 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B25131
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tnVlQbQ+Osf80GEtD2/XmWosAEX59luwGzbhDTMc2sg=; b=ZC4hYHr5ViNYDmSF4u/gSOnnYk
        b0MS6sUS0hS4NJ74MKwTS59XCv9q+eUQVc9nkmpOvJoYGDJo2hgFXgigCVSoQIfFs5t7p1GtVUUpo
        DOycUVikLSGgx+7f8iBDB17GdeEWfPlhxDUwtxZw0ng3ilxzAGF8rqg5n1gpQegdSjBI=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pf5XY-005lzv-H1; Wed, 22 Mar 2023 21:58:36 +0100
Message-ID: <ff4c3a89-f3dc-2ae6-1b11-f2c46944e376@nbd.name>
Date:   Wed, 22 Mar 2023 21:58:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@kernel.org>
References: <51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22.03.23 17:37, Lorenzo Bianconi wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Stop referencing 'features' memory after release_firmware is called.
> 
> Fixes this crash:
> 
> RIP: 0010:mt7921_check_offload_capability+0x17d
> mt7921_pci_probe+0xca/0x4b0
> ...
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Acked-by: Felix Fietkau <nbd@nbd.name>

- Felix

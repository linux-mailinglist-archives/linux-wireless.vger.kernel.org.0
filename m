Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F21850AA87
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441825AbiDUVRQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiDUVRP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 17:17:15 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53349F2C
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c/02Q/vf5R3LFZzkS8JBR0foELszGqvAH/lUEI2ausk=; b=edEm6nmYj4x9gUS0C5+He5pF+/
        jSOofWu05NcKaT1KrzbtjDIqxltnmVOkNgdwtQQhF7wnzne5RZ+keeKNajfi+rUVv1lPG9SOTFeql
        OArLOAQR1xm+ISKZ7+lz/4ObNyeyKYd6EYWLHvs6QJKjCi9nizjGP3372mSgRPtvwg3M=;
Received: from p200300daa70ef20028a36ac9fd74af32.dip0.t-ipconnect.de ([2003:da:a70e:f200:28a3:6ac9:fd74:af32] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nhe85-0006Ib-Gz; Thu, 21 Apr 2022 23:14:21 +0200
Message-ID: <f1b944f5-b440-d32e-84b9-7cb140b0adc6@nbd.name>
Date:   Thu, 21 Apr 2022 23:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] mt76: mt7915: disable RX_HDR_TRANS_SHORT
Content-Language: en-US
To:     "bo.jiao" <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        "lian . chen" <lian.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20220420071144.14573-1-bo.jiao@mediatek.com>
 <46f14357-d02b-cad3-9fa8-7e1962305251@nbd.name>
 <5b0f28fa67b27151a59ea42d9f60e29919f36f36.camel@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <5b0f28fa67b27151a59ea42d9f60e29919f36f36.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi,

On 21.04.22 03:44, bo.jiao wrote:
> hi felix:
> 
> mt7915_mac_fill_rx:
> 	......
> 
> 	if (!status->wcid || !ieee80211_is_data_qos(fc))
> 		return 0;
> 
> 	status->aggr = unicast &&
> 		       !ieee80211_is_qos_nullfunc(fc);
> 	status->qos_ctl = qos_ctl;
> 	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
> 
> 	return 0;
> 
> it will be returned by the condition !ieee80211_is_data_qos(fc) when
> receive non-Qos (null) data, and the status->aggr/status-
>>qos_ctl/status->seqno keep the default value 0.
> 
> mt76_rx_aggr_reorder:
> 	....
> 
> 	sta = wcid_to_sta(wcid);
> 	if (!sta)
> 		return;
> 
> 	if (!status->aggr && !(status->flag & RX_FLAG_8023)) {
> 		mt76_rx_aggr_check_ctl(skb, frames);
> 		return;
> 	}
> 
> 	....
> 
> those packet will be forced to do rx reorder and may incorrectly update
> tid->head.
> https://patchwork.kernel.org/project/linux-wireless/patch/2022042010503
> 8.36443-1-nbd@nbd.name/
> Your replacement patch did not include this change.
> +	if (!status->aggr)
> +		return;
> +
> 
> Thanks.
I posted this patch: https://patchwork.kernel.org/project/linux-wireless/patch/20220420112524.52430-1-nbd@nbd.name/

- Felix

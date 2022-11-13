Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CBF626D53
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 02:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiKMBlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 20:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKMBlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 20:41:40 -0500
Received: from titan5.planetwebservers.net (titan5.planetwebservers.net [51.222.33.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E9DFF3
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 17:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EGOaKAOzcPO4DCwaf6uquZd9h5vl4V8Z0q6Dexnv8tw=; b=lg0lUA+RO/gXNczosK3FOHZsIZ
        giuftCMWgqur8jNb/5JyNYhoryNYHPhYm5eK/ph/tFg7apML336hetvONadHhzw+I3D5twPh40PwG
        WdooCdZNlC4gP8bMcg4G67fkuS4GiUmkdWeNdgX5q6ac5XJXdcY1giSgg9FBES3PXfZgBDdo8gyqX
        bbpM5yDaQieHtbttaBDTxzeYAWLzPz69N2+8EzVkPOyZW4wMCJqEXHMBubDxrJhkySW8UUv8IIIIm
        I804O4N/Llw7I66Tfhc9bfLkDhy/yXrEahtKnK6CgviKGtxLMlQyW3CyCcEwu14rjhlipMVG3LycI
        xOsN+CjQ==;
Received: from [76.75.122.26] (port=51134 helo=[192.168.68.80])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <bjlockie@lockie.ca>)
        id 1ou209-0000SF-6s;
        Sun, 13 Nov 2022 12:41:37 +1100
Message-ID: <150de978-0abf-d1a5-5c1a-82a18ff89d00@lockie.ca>
Date:   Sat, 12 Nov 2022 20:41:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [BUG REPORT] mt76: LED not working on ASUS AC51 USB (mt7610U)
Content-Language: en-US
To:     Ray Jantz <ray.jantz@gmail.com>, linux-wireless@vger.kernel.org
References: <ba072331-b7db-edc3-de77-4496d402f497@gmail.com>
From:   James <bjlockie@lockie.ca>
In-Reply-To: <ba072331-b7db-edc3-de77-4496d402f497@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Try some this stuff:
https://www.topbug.net/blog/2015/01/13/control-the-led-on-a-usb-wifi-adapter-on-linux/


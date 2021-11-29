Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF9462867
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 00:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhK2XlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 18:41:11 -0500
Received: from titan58.planetwebservers.net ([51.79.1.102]:46949 "EHLO
        titan58.planetwebservers.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232149AbhK2Xk4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 18:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc
        :From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HOVjB35jm+WFsYjlR4jt5YfmtXotWCaiMMZkESMQQ4g=; b=gl8rVjMG8UGxyEE6IUO++hyMs7
        th8No6+8/s8SXu9Soq33cSBiHna4h7OFOgK8wLKnIP7LFhLk/D5z4jezH5k8h1P3X0sUvCo2GNQh8
        4eXLU/qWbPnWc5m9PReiLxNvZb7Uwbt4q2C1ZMe2x490DO5j+U8iGyUDWSizpLsZVU++rvGKEP0RJ
        aTKemUH5ZRKIVKaHTbe6x6VMLt5rLQR2h9ccyFuel+nQhIiCfRrVA8XHKzlYAURRyN/CFOnws7Eet
        XH9BXoZRq0MluID27VqqM8eL7QEwMvGvTAFuoBNlFVrSlKPOj72VaqDhb40i3aTgkXcOrQq0r9MVz
        UXF7AHkQ==;
Received: from [98.124.54.9] (port=59128 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1mrqDI-00016r-Mv
        for linux-wireless@vger.kernel.org; Tue, 30 Nov 2021 10:37:36 +1100
Message-ID: <5e815a38-eb5c-7dac-7243-1d734c1acd3f@lockie.ca>
Date:   Mon, 29 Nov 2021 18:37:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: USB for rtw89 driver?
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
Cc:     linux-wireless@vger.kernel.org
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
 <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
 <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
 <917dde5b-36c7-a079-6dc1-7441a2f90745@lwfinger.net>
 <dac5960c-44f0-300e-d3d7-6ae23c3ae64f@lockie.ca>
In-Reply-To: <dac5960c-44f0-300e-d3d7-6ae23c3ae64f@lockie.ca>
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
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Does anyone know what this is?
The releasenotes pdf says it came from Realtek.

https://github.com/shiqishao/RTL8852AU_WiFi_linux_v1.15.0.1-0-g487ee886.20210714

What are the roadblocks to getting USB support in the kernel driver?

Is it possible to have a USB part of the driver that uses the kernel 
part of the driver?


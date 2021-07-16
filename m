Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7D3CB031
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhGPAyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 20:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhGPAyg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 20:54:36 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF96C06175F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 17:51:41 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so8894059oig.12
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 17:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QbFumJIJ7vC9OQABvA0we8EcFGh7zdUheBESdjmTWec=;
        b=kPAzny8lxVz5KlU9WZ1t7zkQcoscUUJso/zcdO4xloOn3MIlfvOrXDQPUDsQXmUXWI
         YP4ohAUGUKJp9HMFhT72HcyNo46ZKwlXOQbdzv9CKGxRQ9kxseE0vHL64u0IdqazkVv2
         8BKh6LeFNUrE1MEUCQrgxcF7Wqk9Bp7YrHj2ZYnXeuuP+K37Z+sppSnfVdBuRNU5yE/k
         lGaB6Q32zmOyt1YVZj78xrYXrAgjUV5CUQ3kOPT1I4KKbZb41OarZRyN97/AaQbPCvdG
         wHE0HXEpCBSyu0qH4rXWd6E5SMGWZhhouzgGXqKEAMuqWGySLrbGADzGzAmGbz++Jc2Q
         IbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=QbFumJIJ7vC9OQABvA0we8EcFGh7zdUheBESdjmTWec=;
        b=RunNrQsk47DW1DFSxCy7RN7XL/1nFTWa+tkKZrIZScpMWrJMqNiEyDiwMpiCigwAvS
         llVcGPBI7OC3gwz+TaoVBk82AwO40i4HhScYZ8oIRDS5jDU+3NWMOtYJunn4eQArkV4/
         D5prd9EejkfjPiqG+SV7SmV4GIg4sh/e2aa9BkDd9njQ37bxPuJRcpCCcrZywJt5d4se
         sT4sYukQGJPMt/yJjNJwnXRolrsYSxx5pL6QvoPlUVUgM8/V6hbimVHVhjki+kW9Lk3C
         WEP1l4Grpt8P4PgPYUFjis1kYo+t7GqSHtO3wUm2vIJbAmFGWjcJHpIALX0vRp7YsJco
         /gKg==
X-Gm-Message-State: AOAM533RBULjxAof06X420l+D8rDZdVxZISrTjRUYZ9Lo4mZK0HZs126
        Er8mTPhT3BBZKAOYqDqGngS0D0oOPiE=
X-Google-Smtp-Source: ABdhPJwTvTNub3dV+O9F9nMSrFREoo2xE4dzVCeqvjYvm7rxQgwGnrD3/LCZru3wNR3VMZavfbMeEQ==
X-Received: by 2002:a05:6808:13c5:: with SMTP id d5mr5656908oiw.163.1626396700354;
        Thu, 15 Jul 2021 17:51:40 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1001.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1001.res6.spectrum.com. [2603:8090:2005:39b3::1001])
        by smtp.gmail.com with ESMTPSA id r1sm1418897ooi.21.2021.07.15.17.51.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 17:51:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Difficulty connecting to AP using rtw89
Message-ID: <f2ee1dbd-28b5-a1e6-8f41-e7ed8dfc2521@lwfinger.net>
Date:   Thu, 15 Jul 2021 19:51:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am trying to help some users of my GitHub repo for rtw89. Several are having 
problems trying to connect to their APs. When their AP scan lists the following:

WPA:	 * Version: 1
	 * Group cipher: TKIP
	 * Pairwise ciphers: TKIP
	 * Authentication suites: PSK
RSN:	 * Version: 1
	 * Group cipher: TKIP
	 * Pairwise ciphers: CCMP
	 * Authentication suites: PSK
	 * Capabilities: 1-PTKSA-RC 1-GTKSA-RC (0x0000)

I have no problems. My scan results show:

         RSN:     * Version: 1
                  * Group cipher: CCMP
                  * Pairwise ciphers: CCMP
                  * Authentication suites: PSK
                  * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)

At least one of them can connect to a hotspot created on his phone; however, it 
also shows Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c). I have tried to 
discover what causes the difference between this value and that of Capabilities: 
1-PTKSA-RC 1-GTKSA-RC (0x0000). No matter how I setup my APs, I always get 
16-PTKSA-RC.

Can anyone help me understand this problem?

Thanks,

Larry

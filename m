Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7533FC738
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhHaMUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 08:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhHaMUE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 08:20:04 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1AC06175F
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 05:19:09 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id s16so8324256qvt.13
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Tu4+uxp4XyX6aEhdHL/PmBEnSH2qrVBxKdrE8vdWq/o=;
        b=dy8HB4lzJSL52K/wsljPKtLha6ge0BpgmR9KcByNe0gN9jMRWNfopow7HgKIYKdqFt
         iCDyMJWv4CSdJPEI3na5JnWZ733ZKtN2B9KF6hN/UXEbCa9YkXYlciDSZEbMtda0Bojs
         hzjqmURkWWZ1etGCombRRoGT1cb3y2CefKHtr4dGaiN9o0aEnF8w8ueO8HflKxMzwT7z
         YY/4Z9ktssn5m4q2WFU1F1MSGlkC8einyb5qEo6/gmws6gqFOe+BUt5NBZHB3sVxbGbM
         Bgz4UO0nxlrVFP814kpaEeJ/50W4eIvJqvTtyCkIFjsOnOuYJnh0yOrQzRRNBXE2h7Ks
         wsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Tu4+uxp4XyX6aEhdHL/PmBEnSH2qrVBxKdrE8vdWq/o=;
        b=tp6Ga7FXnCmeeBBuLo1Gtb6lCON0PqkFOY5/aquqA4NYcS6AWyH7GgxHmYv4nuybgz
         n+1Ve/78++Rg5Te7BQJ1q0UHFjHh30Maw4SBiz8wX8/u1sAgSPYz4D/CInVKBKbE7j4F
         XpDq8ETC5eIPJ3/mKUFvmDaFjmWoOPZHYg0EjL13ZGflp+JWd2V509NjRJrzQxb9DMcm
         cQ33/uvQW1Kp6dfe2LqdMP6imPELwEZ33Bgze40+Zkuu2rwWPaMLDlEh/IQKbz2l8TWr
         xV6hEaFizeoAOHydO9bdBPJorKP/M8TtytOJnKZkcEF9szPhboFdDO1xwBcArsKMOqVO
         H8Dw==
X-Gm-Message-State: AOAM530kUOhN3+l4Ti3qCc/2Yh1vW1WqBoT7DVRr/tFnrld8HCuC7qua
        T8/ZD6bUPJ/AJDt+oif38Z+IRA==
X-Google-Smtp-Source: ABdhPJwkgwmWfLtqZzAkBzK+oIstAvzkmI9KLmkiZ+WpWW303JdtMGdUZLWacSUVEt7A6h7gzc81cQ==
X-Received: by 2002:a0c:f382:: with SMTP id i2mr28575024qvk.43.1630412348785;
        Tue, 31 Aug 2021 05:19:08 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kntaon1617w-grc-28-184-148-47-47.dsl.bell.ca. [184.148.47.47])
        by smtp.googlemail.com with ESMTPSA id p12sm9883818qtw.54.2021.08.31.05.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 05:19:08 -0700 (PDT)
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Netdevconf 0x15 videos, slides and papers up
To:     people <people@netdevconf.org>
Cc:     lwn@lwn.net, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        lartc@vger.kernel.org
Message-ID: <6ee8f309-d8c6-1938-ad7d-477949a59d3c@mojatatu.com>
Date:   Tue, 31 Aug 2021 08:19:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks,

We are pleased to announce that the videos for 0x15 are now up.

All the slides, papers and videos are now up. Visit:
https://www.netdevconf.info/0x15/accepted-sessions.html

The videos can be viewed directly on the 0x15 playlist here:
https://bit.ly/netdev-0x15

Unfortunately we couldnt capture within the videos the full
textual chat sessions that were ongoing during the session
(platform should have it next time we do this).
For access to the text, registered users can still login
into the airmeet platform and replay any session. The content
will stay up for another 11 months.

cheers,
jamal

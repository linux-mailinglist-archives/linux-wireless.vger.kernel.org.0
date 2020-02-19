Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B080163FD0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2020 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgBSIzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 03:55:41 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:42240 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgBSIzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 03:55:41 -0500
Received: by mail-pg1-f174.google.com with SMTP id w21so12370627pgl.9
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2020 00:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iiserpune-ac-in.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=hL/O7b8SoX5WCDYIKKY7lQQed0gmaDD1fYBCQeMr9ic=;
        b=fEvsTQcPu/O/yqUQnHG76+JhwfenCAB8KTCWRa3Z8WajjbHc02D6kZV679o9/Di2cN
         hbLV4tLZkJ/mx0jp/tU3deCkdWoCAZxKFl+zO/Q1YHaY7o5ah8gdEiS1MKlIdToChEK6
         qsUHwqRaZ3JRLLGS7RHZHBKeGmhqC1wfq4a7T8YvHOrLua6w5wQwa/Im7QbwJeKG8Xft
         /0ZWz5mwfpDmqrzvQVSZcUfNAgN2gtdAZqnbtTAEVD2TkOoWtfJBDFvEqkUPeyG3KsF1
         kjHyQfPBVltRkpFWv7ggY+JnmGvNtj/iPrGjRpvdusjw9C1UyUIpQiu5F4NvSXvOKvOf
         tNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=hL/O7b8SoX5WCDYIKKY7lQQed0gmaDD1fYBCQeMr9ic=;
        b=OtqZcpP0XPb2neYkXNjLTujlbCBQPT4iLGouzllEF/Kzv6mjaC+8A7DRZUcWGkgeTO
         ZuVQ732nRRuxZuhbHmmRxMdIagHa/smfizLg/AaBH0tBoPPQHxHAkrQG5PMu2jj3DPkv
         67GgK/shl2zZH9xLexrF058UqfiebrXFSWDzcvDRLcJuGF+U5t1Pn+obs2u1tHbHjZyW
         dWEyIikdQ8f03PLs8jaye8dJKmRgBT1esc98CdM3w6KOQ/ws3yuELaOEMWpnRDiBUHbH
         ticzcKT38l+BvkokdYToDeS7wN/ox331Mx/x9uwXTXP/zNf0MZdx86/D6EZLl+SreInX
         ueGA==
X-Gm-Message-State: APjAAAUjfRajUh015xjhTwNAVbO8R84Sm+epjIJWjcw/AlwOBFGFBY01
        ZSghXRyh6T7h5pnQ8cPwBKXjJ7MOEbs=
X-Google-Smtp-Source: APXvYqwlFtMS8frQ4S4bZLui98fFk1kdQt7pZLx9o8/6O+DWvpLAHF7NZqi3unNfkEeR7GZZbXNzJQ==
X-Received: by 2002:aa7:8587:: with SMTP id w7mr25954192pfn.39.1582102539483;
        Wed, 19 Feb 2020 00:55:39 -0800 (PST)
Received: from [10.10.3.36] ([14.139.123.36])
        by smtp.gmail.com with ESMTPSA id u3sm1649262pjv.32.2020.02.19.00.55.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 00:55:38 -0800 (PST)
To:     linux-wireless@vger.kernel.org
From:   Ashish <ashishkumar.yadav@students.iiserpune.ac.in>
Subject: Commit d1d1a96 in rtl8188ee module causes issues when connecting to
 my institute's wifi
Message-ID: <4830c992-1a09-9989-ab29-ea403b910551@students.iiserpune.ac.in>
Date:   Wed, 19 Feb 2020 14:25:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The commit d1d1a96 (at 
https://github.com/torvalds/linux/commit/d1d1a96bdb4408d02e2bfcb32b71aba165458a80?diff=unified) 
in rtl8188ee module causes problems while connecting to my institute's 
wifi. I am not able to connect to that wifi after this commit. The 
journalctl output is at http://ix.io/28IX (look for "AP off, try to 
reconnect now").

The problem is with removal of the struct. Adding the struct back in 
trx.h solves the issue.


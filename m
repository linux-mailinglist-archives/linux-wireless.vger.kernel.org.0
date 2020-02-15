Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1BF1600BD
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2020 22:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgBOVwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Feb 2020 16:52:05 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38422 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgBOVwE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Feb 2020 16:52:04 -0500
Received: by mail-qk1-f178.google.com with SMTP id z19so12734969qkj.5
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2020 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hmW9uUExBD5bXGwCqUZfBGtN7UxUxJa7T9gal2J1nMw=;
        b=lro82BIjIt71jSDjx5dHHbzh9O7aWp2UMOhqlTodsz9vML6UAGUeWuq66gk4vMa1KM
         wB7ttSJCtBHspGgnZPdTVXtbh9eZFi0tBEOSohR7w9BHcNOEAS9P0JocqitohUb0uj2n
         hdDVVINV98Ki8IBwknAUb+57kO5dnP4TazBiZ7vvMdlExyyaxuF+5j33v+mXAqoSeDvk
         I5DmHX0aLCXHGqiYXMRxF1G4Ye7Y778xR4Qg/0LMzfopYYsNXICdUhvZZrQa4E91qOV+
         iRKVQIGb6GSQs6Y2gLetjtuksfSzS/MioAjxvOaX6XRJsXg/8XmH8IptWavD0VTLAslc
         TUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hmW9uUExBD5bXGwCqUZfBGtN7UxUxJa7T9gal2J1nMw=;
        b=dk0vINeZCmdDtx6MOr6JGn5MpAZsQX3HzjkhoZ4TtiMnovbpI6gUupqcJnn8dzf0GI
         NQ5slpo9zwJVTMC4w5MqOMkjCb+UMDxchXWSAbbhyBqp3PsFoAJp8ApB4UIXK2VeQoDa
         zKb1p03/o/kUjGyD2bRdl6+RMtLpMK5Xg3LHwMagFM41UVQpuumhvLZCPdsP47fYL5Pc
         9DmtTrFs6JYb9SW6sOY5NGqalgHhuoUZhgeNoAKckpyMcRlJhUs9TlXSNwMRjUAeuws8
         3++yG7HYHb/0g3hhYP+nR4mE6zFdAKdrnVvdrcTg2wG1M1mf5SdsgerZFbvRXrgQyIQh
         6tfg==
X-Gm-Message-State: APjAAAXxluJnOGFjKFpH0f4nQmXcRkt0wSyEvF2wHfaH5TLVwGMxvxpz
        BwotOvkdtrt4EwgDVWmRnJ9nPQ==
X-Google-Smtp-Source: APXvYqxoANsLhigIQHncTXQO+p9XZM6WRd9+aMZr6+BLHAH7am9ZHGovaz09CyjBIK2DzMSZVwOwpg==
X-Received: by 2002:a37:3c5:: with SMTP id 188mr8428230qkd.312.1581803522429;
        Sat, 15 Feb 2020 13:52:02 -0800 (PST)
Received: from [192.168.43.235] ([204.48.77.136])
        by smtp.googlemail.com with ESMTPSA id o17sm6004607qtq.93.2020.02.15.13.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2020 13:52:01 -0800 (PST)
To:     people <people@netdevconf.info>
Cc:     prog-committee-0x14@netdevconf.info, speakers-0x14@netdevconf.info,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, lwn@lwn.net,
        netfilter-devel@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        lartc@vger.kernel.org, Christie Geldart <christie@ambedia.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Subject: 0x14: Schedule out!
Message-ID: <c8d8a7be-834e-1bab-9c6e-fa6f39ea6040@mojatatu.com>
Date:   Sat, 15 Feb 2020 16:52:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


We are pleased to announce the tentative schedule
for 0x14. There may be some minor changes
going forward - but the overall theme will remain.

For the schedule and logistics please see:
https://netdevconf.info/0x14/news.html?schedule-up

Come one, come all!
Again, as a reminder - 2 days to go for end of
early bird registration. See:
https://netdevconf.info/0x14/registration.html

cheers,
jamal

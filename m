Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9632D134
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfE1VuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 17:50:04 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:37529 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfE1VuD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 17:50:03 -0400
Received: by mail-qk1-f178.google.com with SMTP id d15so133312qkl.4
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=z/7pXtnMoeggltCSRBU8g1Ph8yIX8YybN3BYB2Nub7M=;
        b=M88efnygAdBVsYYFERpz+hJnD0s88uqDVdZT9yN3lhrUh3AonvywZq0nWRAPIuuFTe
         qGzK6FeNsQii8STBodXVAqddlygBU2ed+EuCQsZZ4KYrHdsw60u9ffajOGt4mIl5NVEI
         HlY9hWWT/YRJet4aciG7s6FN+44st/4UHq95umr9jx9pLfWhSm/RenJNaaxoqpLfH5Ba
         o/s8xYGQZDBf51l7v78rgPS2+7qWdj08Yz7yapHEoCPsknAz2FLxQNEG+O7LWiYwI99h
         blQ0Wyy6F8ecKqr14Z7roi0cC8On3INyXf7tYQO+1+c+H3YEMqiFcomlodFu0g6/rJxn
         KrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=z/7pXtnMoeggltCSRBU8g1Ph8yIX8YybN3BYB2Nub7M=;
        b=D/h87faVmpD+0nbpIDHtw42H+tEDIwOT5LAvFTmtp7vqEI5lUy5lc5MQtkYhM30Ub/
         F/D75P4s4r/LzkrCkYUIB0F5rhVzlW2SSHZOKxDjdSLp5IDHoUQZSVJEGfjjmCAbAwa9
         kYXd+oJRYYzVMEkbLjoYq/0RnCPlwvrC0HCHJZjfWvY0aROVFiwi4MQWbqH7rKv+Eal6
         lJRIBA7dY1u/4464MiSY8umKccwRcfTHBWkvcGtLtpzpkFvI/uwtWYH0UM83umz3k7xE
         Gi+gskGWnCIbnQbXdfWmuFhpYAxp8igbpCG7vDF+AvJKDSMD6DX1Mev/1pcrPvcwed67
         h+3w==
X-Gm-Message-State: APjAAAU2aAinMvRVpA0mOkJxqo4FqjRa8qfXEWPqN+8gGtJqAdceTgY9
        m9s34WEONWd7QOpF7zC/0Fb49Q==
X-Google-Smtp-Source: APXvYqxOH8D4ZE7SXotoewPgOf+GhqHB7b/bC9fSXM70aMXHG7V34K7y28f2oxWsMOwuEjRLQ5F10Q==
X-Received: by 2002:a37:a652:: with SMTP id p79mr91353080qke.73.1559080202791;
        Tue, 28 May 2019 14:50:02 -0700 (PDT)
Received: from [10.0.0.169] ([64.26.149.125])
        by smtp.googlemail.com with ESMTPSA id e5sm1404132qkg.81.2019.05.28.14.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 14:50:02 -0700 (PDT)
To:     people <people@netdevconf.or>
Cc:     "board@netdevconf.org" <board@netdevconf.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org,
        lwn@lwn.net, netdev@vger.kernel.org, lartc@vger.kernel.org
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Announcing Netdev 0x14
Message-ID: <4e8a273f-e78b-b2cc-a8fb-7c8f423b16ff@mojatatu.com>
Date:   Tue, 28 May 2019 17:50:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Folks,

Based on the feedback we received in the conducted polls,
The NetDev Society is pleased to announce that Netdev 0x14
will take place March 17-20th, 2020 in Vancouver, Canada.

The new format is:
- 3 days talks + 1 day of tutorials and workshops
- The 3 day talks will be single track talks with more breaks
and breakout rooms available for discussions.

The call for papers will open up on Tuesday, September 17, 2019.

More details will be posted here:
https://www.netdevconf.org/0x14

We are going to bring you more updates as they become available to us.
For regular updates, please subscribe to people@lists.netdevconf.org

If twitter is your thing then follow us: @netdev01
and use hashtag #netdevconf


cheers,
jamal

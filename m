Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B030265610
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 02:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKAdC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 20:33:02 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:47166
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbgIKAc7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 20:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599784378;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=5fCdSodwX2IYE/FOZLWYqqVtBJL0BNkXKHcmv2sP5mY=;
        b=V2tIwO2G8A3Ixf/WXEJKLIaeyQlgB4ZrR7pKZWNBRYsUb0EFfZQvqdzja+Z1uM3g
        Yv6GgL7sanSx/z2tH06JH4ziVpuKo6YhhVKJLVta60E/RsbJUw4faGUEK4AUqFoIVZt
        O9bEXrhgAmYArJqLCil3IgMJR1l7XTNwXpoMi+gQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599784378;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=5fCdSodwX2IYE/FOZLWYqqVtBJL0BNkXKHcmv2sP5mY=;
        b=U79htQW1vxTTfBS2rncO2FlPgFd5ZpZKRqXfU0Qq/vJ4uZInfQsXQiO4wBBYcFp6
        9NbqMW/ITbFwwyKuGJRazJbc8tT3p+NuESdjzP3T5u8P4ZvKgQtn4I4wOSSZVgkyQZl
        C65gp6wsRdel1faXnS+WGJFYT0t1mX+XfAczYFDU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DDC6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v5 0/2] Unsolicited broadcast probe resp support
Date:   Fri, 11 Sep 2020 00:32:58 +0000
Message-ID: <010101747a9460e8-f3176d2c-3ba6-43a9-a992-f1eac5019d94-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.11-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unsolicited broadcast probe response tranmission is used for in-band
discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior for
fast passive scanning).

v5: Addressed comments.

Aloka Dixit (2):
  nl80211: Unsolicited broadcast probe response support
  mac80211: Unsolicited broadcast probe response support

 include/net/cfg80211.h       | 18 ++++++++++++++
 include/net/mac80211.h       | 20 +++++++++++++++
 include/uapi/linux/nl80211.h | 36 +++++++++++++++++++++++++++
 net/mac80211/cfg.c           | 41 ++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  7 ++++++
 net/mac80211/tx.c            | 29 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 48 ++++++++++++++++++++++++++++++++++++
 7 files changed, 199 insertions(+)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
prerequisite-patch-id: 12e14158dbf44110386d66ca58cebcec0cd190e7
prerequisite-patch-id: 78e6d243db88084637a2ac1d4d0cd5c7e5ce4e5f
-- 
2.25.0


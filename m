Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B888125FAE6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 15:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgIGM5R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 08:57:17 -0400
Received: from crapouillou.net ([89.234.176.41]:60676 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgIGMxB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 08:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599483178; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=UnxJICEe6keNhZ+g+3KfIs9RIc5CmeJtpKbW3vFc6Gc=;
        b=bDxS4GJuM+tZ0jeUB8ROErvFY10aRpwcG9XbeMvtDvDv5hKO/nlAA6eJ5XQ2GNoJiToMK/
        ajwIm44N3zHExvFJODnOFYoq1iLOdJAx8NXJJsc+l1heZq1N+jVomztXWk6ZDKj+ynEEXj
        eWwXKGfGeRAUlW8/0XAxNMGNC0VyK/Y=
Date:   Mon, 07 Sep 2020 14:52:48 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: alternatives to screenscraping iw?
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, od@zcrc.me
Message-Id: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

We're trying to move away from ifconfig/iwconfig and switch to use 
ip/iw on our embedded systems. It works good, but we can't really adapt 
our current tools (mostly Python wrappers). iw -h specially says not to 
screenscrape, but we don't really have an alternative, do we?

Would it be possible to split iw into a shared library + binary? Then 
it'd be at least possible to create wrappers. Another idea would be to 
have a mode for iw to output json, like 'ip' does.

Cheers,
-Paul



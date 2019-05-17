Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2121E3A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfEQTa3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 15:30:29 -0400
Received: from nbd.name ([46.4.11.11]:37360 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfEQTa2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 15:30:28 -0400
Received: from p548c8c9f.dip0.t-ipconnect.de ([84.140.140.159] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hRiYk-0006cc-2M; Fri, 17 May 2019 21:30:26 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 0/7] iw: various bug fixes
Date:   Fri, 17 May 2019 21:29:49 +0200
Message-Id: <20190517192956.18372-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These fixes were extracted from the latest Intel/UGW. I am assuming they
ran static code analyses/Klocwork in the source.

John Crispin (7):
  iw: fix memory leak inside register_mgmt_frame
  iw: fix endless loop inside handle_mgmt_dump
  iw: fix memory leak inside handle_cac
  iw: fix fd leak inside handle_netns
  iw: fix memory leak inside parse_sched_scan
  iw: fix memory leaks inside handle_scan
  iw: fix fp handling inside handle_vendor

 mgmt.c   |  4 ++++
 phy.c    | 25 ++++++++++++++++++-------
 scan.c   | 34 +++++++++++++++++-----------------
 vendor.c |  5 ++++-
 4 files changed, 43 insertions(+), 25 deletions(-)

-- 
2.20.1


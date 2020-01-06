Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496A8131479
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAFPKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:10:31 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41872 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFPKb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:10:31 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C5389580068;
        Mon,  6 Jan 2020 16:10:29 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 0/4] parse more events, updates for 5.5
Date:   Mon,  6 Jan 2020 16:10:20 +0100
Message-Id: <20200106151024.124315-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Markus Theil (4):
  iw: event: handle interface add/del
  iw: event: parse stop ap and frame wait cancel events
  update nl80211.h
  iw: info: add missing extended flags for 5.5

 event.c   | 36 +++++++++++++++++++++++++++++++-----
 info.c    |  7 +++++--
 nl80211.h | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 7 deletions(-)

--
2.24.1


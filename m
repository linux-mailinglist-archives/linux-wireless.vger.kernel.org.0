Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2AC96627
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfHTQUm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 12:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfHTQUl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 12:20:41 -0400
Received: from localhost.localdomain (unknown [151.66.62.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE056230F2;
        Tue, 20 Aug 2019 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566318041;
        bh=dX/uu9SaFyMrF72FSI3CXk+vXjd3hL2bmjG2+P4Mm9I=;
        h=From:To:Cc:Subject:Date:From;
        b=kjDYH8tayh9Ojvee7H1hACu38BzmCe4JO608aJGsqUM/HM3XVdt4xiaZzsqIg5dtY
         g2wWNjuwq7t2xAOBnzzYJR3B9HDuVZMAh70Te06LdFh0xiGZ3onvzMTZJi1xgbWATx
         Ss71Lv7v/tMljH9sElmoTOzlBDgJLmPEbdQhqy2I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        koen.vandeputte@ncentric.com
Subject: [PATCH 0/4] ath9k: dynack: fixes + cleanup
Date:   Tue, 20 Aug 2019 18:20:18 +0200
Message-Id: <cover.1566317488.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve ath9k dynack reliability in p2p/p2mp dynamic topologies.
Improve code readability removing duplicated code.
This series has been tested by Koen Vandeputte on multiple outdoor
links/devices.
This series is based on 'ath9k: dynack: fix possible deadlock in
ath_dynack_node_{de}init'
https://patchwork.kernel.org/patch/11100409/

Lorenzo Bianconi (4):
  ath9k: dyanck: introduce ath_dynack_set_timeout routine
  ath9k: dynack: properly set last timeout timestamp in ath_dynack_reset
  ath9k: dynack: set max timeout according to channel width
  ath9k: dynack: set ackto to max timeout in ath_dynack_reset

 drivers/net/wireless/ath/ath9k/dynack.c | 93 +++++++++++++++++--------
 1 file changed, 63 insertions(+), 30 deletions(-)

-- 
2.21.0


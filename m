Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D28611F6E4
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2019 09:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfLOIyY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Dec 2019 03:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfLOIyY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Dec 2019 03:54:24 -0500
Received: from localhost.localdomain (unknown [151.66.51.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 224E420700;
        Sun, 15 Dec 2019 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576400063;
        bh=V1ahdnZO8ibqvXWWHwlm+MzLd9i8kZIO6TcGOWAg3c8=;
        h=From:To:Cc:Subject:Date:From;
        b=IkOnr9DmfOG+gh9h5PqSBVxCh4SccFW5LTdMMsrpJ67sXWzVLk6to37rPvEHtcoG7
         Ij+2aseFOwPp3CobGmgD0V6fng92ySCjjBlTrmbSOBHNVH4Df3dNQ47gH5iqX/apOU
         ClsnTl/NO2d6b6G3CMP2BxH8/9O/d6fyzWHcUNCw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] improve mt76 led code readability
Date:   Sun, 15 Dec 2019 09:54:08 +0100
Message-Id: <cover.1576399834.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve code readability relying on FIELD_PREP macro for led register
definitions and remove open coding

Lorenzo Bianconi (2):
  mt76: mt76x02: simplify led reg definitions
  mt76: mt7603: simplify led reg definitions

 drivers/net/wireless/mediatek/mt76/mt7603/regs.h  | 12 +++---------
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h |  9 +++------
 2 files changed, 6 insertions(+), 15 deletions(-)

-- 
2.21.0


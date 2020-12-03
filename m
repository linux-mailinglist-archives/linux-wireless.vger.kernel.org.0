Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7A2CD67D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 14:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgLCNQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 08:16:43 -0500
Received: from mail-m963.mail.126.com ([123.126.96.3]:57094 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgLCNQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 08:16:43 -0500
X-Greylist: delayed 9098 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 08:16:41 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ExFPH
        COLd096nai3tHpoE+85NQSm9PMpe0XKckFen/s=; b=b+D3T17+Qe4xOq+Nro12r
        +jRbsprJBqLQ0BEJp0eFIgpLNK9c52sqOqnnl4sOVXJTOBObtqOAcq/rIvqopfTD
        xKgBYfO0qkuQ+y55PJ5AJSaojuzYcYQdJvtMJ6M+hoFwZnrfMv2KE5Fp5sWnNLsb
        ABUi4K2pgQOOypngfsiwvI=
Received: from localhost.localdomain (unknown [140.207.81.18])
        by smtp8 (Coremail) with SMTP id NORpCgBX1mZ7XchfRfkdOQ--.19890S2;
        Thu, 03 Dec 2020 11:37:36 +0800 (CST)
From:   zhouliangya@126.com
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, lzhou <zhouliangya@126.com>
Subject: [PATCH 0/1] ath10k_pci_wait_for_target_init() should relax cpu for other task instead of calling medelay() so that cpu can run other tasks. Signed-off-by: lzhou <lzhou@sonicwall.com> ---
Date:   Thu,  3 Dec 2020 11:37:28 +0800
Message-Id: <20201203033729.382088-1-zhouliangya@126.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBX1mZ7XchfRfkdOQ--.19890S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RXjjyUUUUU
X-Originating-IP: [140.207.81.18]
X-CM-SenderInfo: p2kr3z5ldqw5bd6rjloofrz/1tbijgHvsVpEBN+8AQAAsp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: lzhou <zhouliangya@126.com>

 drivers/net/wireless/ath/ath10k/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10D21FD2FC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQQ7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 12:59:15 -0400
Received: from lists.nic.cz ([217.31.204.67]:52432 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQQ7P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 12:59:15 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 19A0F140641;
        Wed, 17 Jun 2020 18:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1592413153; bh=cWkt2xSVrdiEy1s6iOoocNP+lewGcSDGwRJhEbkh2Qk=;
        h=Date:From:To;
        b=rlje6GgRguakldTCYOCUiI4zq6OpcmoSvNKmhHA5m+cIqJx2NViZFWmnbM0uLI3tc
         R/x0s5L0Kyr7jTNYZGU/rbSLQ/AketPhpbn/XsHYJa5mbcchPHsa6vT2vK0fqwGPyS
         HWqoe99d/z/PAJNC3Ni2V6WQ5Nk1J8O0ndfjqclU=
Date:   Wed, 17 Jun 2020 18:59:12 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>
Subject: mediatek mt7915 status and devices?
Message-ID: <20200617185912.631766ff@nic.cz>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

what is the current status of this driver? Is it already usable as a
stable AP for 802.11ax?

And are there some WiFi cards utilizing this chipset? We would like to
look into this for the Turris routers.

Marek

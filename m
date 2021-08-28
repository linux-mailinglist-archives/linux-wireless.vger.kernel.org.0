Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910583FA6D9
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Aug 2021 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhH1Qwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Aug 2021 12:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhH1Qwn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Aug 2021 12:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FAC460E52;
        Sat, 28 Aug 2021 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630169512;
        bh=w8yxTDhsyatj2HXWsKunsFutrJSQY73FBUubuWhLb7Q=;
        h=Date:From:To:Cc:Subject:From;
        b=CBKG4DhrGMnb6NdF4T64ymUCl3zzDEa/VPvypctTS8izfv3djiNQsQAPnnpPj5G1g
         rtUwxO3IqiUkXO5GgDnRwk3dkWGYCc6YC+yWuOxB3sOeBFCtiHiSwSug6+4tozci0N
         j/zo67XZHltZoL96q4nWVTSqVPQsMvpIPJcYjoCmK2/QjWl3VGE3u5iXXVK/Rqihuo
         ELFQfC+JV1PIUmqXdC+Y7QPpne6RkW1vvqgFwTrbGMelEPf/9c4dANC/sXLAYS9QhS
         4Z6PFPvxdkC09dWz8g1r3EdhDD4BCWHRYbhUqUbfXYz1+ePQlO+VWza/P2pxFl5MJn
         p4KsjlbnRMw+Q==
Date:   Sat, 28 Aug 2021 11:51:51 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2021-08-28
Message-ID: <YSppp88rcmotF5Bs@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2021-08-28) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2021.08.28.tar.xz

The short log of changes since the master-2021-07-14 release is below.

Thanks,
Seth

---

Bjørn Mork (1):
      wireless-regdb: Update regulatory rules for Norway (NO) on 6 and 60 GHz

Seth Forshee (1):
      wireless-regdb: update regulatory database based on preceding changes

Timo Witte (1):
      wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz

Victor Bayas (1):
      Update regulatory rules for Ecuador (EC)

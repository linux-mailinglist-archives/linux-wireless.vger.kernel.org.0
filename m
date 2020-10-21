Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639352953D7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Oct 2020 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505780AbgJUVH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 17:07:28 -0400
Received: from mail.kloenk.de ([195.39.247.6]:59230 "EHLO mail.kloenk.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505713AbgJUVH1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 17:07:27 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 17:07:27 EDT
To:     linux-wireless@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kloenk.de; s=mail;
        t=1603314081; bh=8jCPpt32xz4mzMEAPDMjPg61CZWNRl9/MOJ+2OK9H74=;
        h=To:From:Subject:Date;
        b=E/j2wF9pr5hhwhf6s9f7LJ/B3qYg6VzKF6PBU/W2vGBBLkdO4nEbgapTBzFI/sRi4
         X7sUCJ91bTxAoY8lvTtgilxx/2h5H7i9sOMujTOMVCwwK14klYQE9l4r4ZZppdJ2gI
         4hZwGmHbFGGZtu1r+rInb0DpDtd5a+7z1o38XVWs=
From:   "Finn Behrens (Kloenk)" <me@kloenk.de>
Subject: NL80211 usage
Message-ID: <667394ec-ac0e-4f09-ec2a-57350b886112@kloenk.de>
Date:   Wed, 21 Oct 2020 23:01:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm trying to use NL80211 to inform the kernel of a new regulatory db. I
cannot find enough documentation, to create code that does that. I found
that iw uses NL80211_CMD_RELOAD_REGDB, but I don't understand their
macro system, to create C code from it. My end goal is to run this code
from rust, but I should manage to convert C to rust. Hope anyone can
point me in the right direction to achieve this.

- kloenk

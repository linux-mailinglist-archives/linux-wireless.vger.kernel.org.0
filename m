Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79D21BE2E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGJUA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 16:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgGJUA1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 16:00:27 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 220E22075D;
        Fri, 10 Jul 2020 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594411227;
        bh=P3wpcTeRzR1W7CsDV4CKETpMMwO9CpwhiI6JROxgy/c=;
        h=Date:From:To:Cc:Subject:From;
        b=hdeT8rrYYu/udjXGyQJF+Gm/hBBwY75ykez1Hzps7vAkXzgbjHH0FEqIdOHNmZjR2
         M7+kYkgeWzvnSO9YIEOb+yPh4hBSrwPOcfUuI8VS+vssHLp6OMdMSrQQ7+8LBwC3Bn
         QJXh7c/Bt1cGCcR1O6PaQoS7+YSzK8gwbpLP6bCA=
Date:   Fri, 10 Jul 2020 15:00:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Add ath9k-devel archives to lore?
Message-ID: <20200710200025.GA75493@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ath9k-devel mailing list was closed in 2017 in favor of
linux-wireless (per
https://wireless.wiki.kernel.org/en/users/Drivers/ath9k), but the
archives contain information that may still be useful.

For instance, Pali just sent me a link
(https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html)
about an issue with PCI enumeration.

The ath9k-devel archive still seems to exist at
https://lists.ath9k.org/pipermail/ath9k-devel/ and
https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/

https://korg.docs.kernel.org/lore.html says pipermail archives *can*
be used, but it's better to start with something else.  

Is anybody interested in adding the ath9k-devel archives to lore?  If
so, does anybody have an archive to start with?

Bjorn

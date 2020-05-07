Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B41C9708
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 19:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGRC5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 13:02:57 -0400
Received: from mx3.wp.pl ([212.77.101.10]:46777 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgEGRC5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 13:02:57 -0400
Received: (wp-smtpd smtp.wp.pl 10793 invoked from network); 7 May 2020 19:02:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1588870974; bh=pWsuXddhHdfzjfjL0oA+K3lu1UYNsC1ILHSc7LqdoVc=;
          h=From:To:Cc:Subject;
          b=O0B09BKk5uIvaXQjZjNkAYaAKxdSEuzcIS++CKZtyH4NMBu49N/D7t2HEtVKDhMUV
           tazwRfbsVkdkkdYRT0KUI4mLs8uYoOT8Xc4CkDM/egYRjVBrQU3xS50KECdtZH6zxT
           L2hIowXUVfTc5Ywc1Lt81stoogn9B8EebUzDpLRk=
Received: from unknown (HELO kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com) (kubakici@wp.pl@[163.114.132.1])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <nbd@nbd.name>; 7 May 2020 19:02:54 +0200
Date:   Thu, 7 May 2020 10:02:46 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] mt76: fix different licenses in same driver
Message-ID: <20200507100246.1e902bc8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <d32134a6-9673-521f-22ee-871aa2284af0@nbd.name>
References: <3a5cb822eb4cd81d32b5480f1235c992ea4fbe06.1587193872.git.ryder.lee@mediatek.com>
        <d32134a6-9673-521f-22ee-871aa2284af0@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: c01c1e78ec6834abc06a270938237615
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [gZIj]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 7 May 2020 15:30:24 +0200 Felix Fietkau wrote:
> Hi Ryder,
> 
> I think for this patch we need an explicit ACK from Stanislaw Gruszka
> and Jakub Kicinski (both Cc'd), because mt76x0 was licensed under GPL.

Thanks, yes, you definitely need an ack, especially from folks who have
their copyright on the files :/

My personal preference for the license was expressed clearly when the
code was written and it is GPL-only. Felix, if you prefer the clean up
I'm happy to ack, but I see no reason to downgrade the license at
vendor's request.

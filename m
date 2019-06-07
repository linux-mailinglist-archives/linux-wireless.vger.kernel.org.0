Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0093E392C4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfFGRHu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 13:07:50 -0400
Received: from mx3.wp.pl ([212.77.101.10]:45263 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfFGRHu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 13:07:50 -0400
Received: (wp-smtpd smtp.wp.pl 1711 invoked from network); 7 Jun 2019 19:07:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1559927268; bh=7hyXnxTgb+Lex34tVPKUq4v+Bm01NeIG4M56AvblYqU=;
          h=From:To:Cc:Subject;
          b=wOnjKo/s0J5cO6xXF9SxjaqwR5Yw+BBsDPP9mUGKs5NSmw8vi2FE1qmG7qZ4YZmSi
           rpqN5INkzXk+aZ1WHOv0rg6OKVYsOgbtCYZUkZBz9nJBRKF67+iM4oCzAxE9LBxgZv
           ImWqtEV1fpTiryj/S6U+UXyAGsYj7ULsg3V9/WIg=
Received: from unknown (HELO cakuba.netronome.com) (kubakici@wp.pl@[156.39.10.47])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <lorenzo@kernel.org>; 7 Jun 2019 19:07:47 +0200
Date:   Fri, 7 Jun 2019 10:07:43 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v2 0/2] mt7601u: do not schedule {rx,tx}_tasklet when
 the device has been disconnected
Message-ID: <20190607100743.3d137d5f@cakuba.netronome.com>
In-Reply-To: <cover.1559906499.git.lorenzo@kernel.org>
References: <cover.1559906499.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 05bb39548d98dbc18d43904952ce69a4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gePE]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri,  7 Jun 2019 13:48:08 +0200, Lorenzo Bianconi wrote:
> Do not schedule {tx,rx}_tasklet when the usb dongle is disconnected in order to fix
> {TX,RX} urb mismatch warning
> Fix possible memory leak when the device is disconnected while passing traffic.

Acked-by: Jakub Kicinski <kubakici@wp.pl>

Thanks Lorenzo!

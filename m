Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0440311662
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEBJQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 05:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfEBJQN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 05:16:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9F0B4627A;
        Thu,  2 May 2019 09:16:13 +0000 (UTC)
Received: from localhost (ovpn-204-54.brq.redhat.com [10.40.204.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B78F600C7;
        Thu,  2 May 2019 09:16:13 +0000 (UTC)
Date:   Thu, 2 May 2019 11:16:11 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: Re: [RFC/RFT 3/7] rt2800: initial watchdog implementation
Message-ID: <20190502091610.GA2366@redhat.com>
References: <1556788021-6531-1-git-send-email-sgruszka@redhat.com>
 <1556788021-6531-4-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556788021-6531-4-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 02 May 2019 09:16:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 02, 2019 at 11:06:56AM +0200, Stanislaw Gruszka wrote:
> Add watchdog for rt2800 devices. For now it only detect hung
> and print error.
> 
> [Note: I verified that printing messages from process context is
> fine on MT7620 (WT3020) platform that have problem when printk
> is called from interrupt context].
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Please drop this patch, it was posted accidently. 

Stanislaw


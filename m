Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE28A1B32C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfEMJsl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 05:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfEMJsl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 05:48:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25C86307D850;
        Mon, 13 May 2019 09:48:41 +0000 (UTC)
Received: from localhost (unknown [10.40.205.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 956236A96C;
        Mon, 13 May 2019 09:48:38 +0000 (UTC)
Date:   Mon, 13 May 2019 11:48:37 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190513094837.GB15694@redhat.com>
References: <cover.1557591530.git.lorenzo@kernel.org>
 <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
 <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513084127.GA3127@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 13 May 2019 09:48:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 10:41:28AM +0200, Lorenzo Bianconi wrote:
> > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > 
> > > Introduce a knob in mt7603 debugfs in order to enable/disable
> > > edcca processing
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > It's good to explain what edcca does and how the file is used supposed
> > to be used. In other words, have a small introduction for the user.
> 
> Hi Kalle,
> 
> edcca is used for adjusting energy detect based on CCA thresholds.
> The code was already there so I just reported the acronym.

What for it is needed ?

Stanislaw

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A458AD5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfF0TP5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 15:15:57 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53302 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0TP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 15:15:57 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgZs8-0003jz-Va; Thu, 27 Jun 2019 21:15:53 +0200
Message-ID: <a6c87741bc3e992bf61d2706834e069917018745.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] ath10k: pci: remove unnecessary casts
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 27 Jun 2019 21:15:48 +0200
In-Reply-To: <58e8952b87c8aa533c15fe5650f3f71288377f36.camel@sipsolutions.net> (sfid-20190627_211239_098282_F39328B4)
References: <1561661250-30528-1-git-send-email-kvalo@codeaurora.org>
         <1561661250-30528-2-git-send-email-kvalo@codeaurora.org>
         (sfid-20190627_204740_465294_470A1055) <58e8952b87c8aa533c15fe5650f3f71288377f36.camel@sipsolutions.net>
         (sfid-20190627_211239_098282_F39328B4)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-27 at 21:12 +0200, Johannes Berg wrote:
> On Thu, 2019-06-27 at 21:47 +0300, Kalle Valo wrote:
> > Fixes checkpatch warnings:
> > 
> > drivers/net/wireless/ath/ath10k/pci.c:926: unnecessary cast may hide bugs, see http://c-faq.com/malloc/ma
> > drivers/net/wireless/ath/ath10k/pci.c:1072: unnecessary cast may hide bugs, see http://c-faq.com/malloc/m
> 
> I think you cut off the link there, did you mean
> http://c-faq.com/malloc/mallocnocast.html perhaps?

Which I should've read before replying ... WHAT? We consider calling
undeclared functions an *error* in the kernel, this is quite pointless.

johannes


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADA443029
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfFLTaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:30:20 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55224 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfFLTaU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:30:20 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hb8wr-00076b-Jp; Wed, 12 Jun 2019 21:30:18 +0200
Message-ID: <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 12 Jun 2019 21:30:15 +0200
In-Reply-To: <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com> (sfid-20190606_204137_150382_A8C8457A)
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
         <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
         <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
         <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
         (sfid-20190606_204137_150382_A8C8457A)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-06 at 20:41 +0200, Tom Psyborg wrote:
> 
> Applying this patch instead of v1 broke WDS operation between two
> Litebeam AC Gen2 devices:

I'm confused, and not even sure which version I applied now.

Manikanta, can you please check this and which version I have and which
changes I might need?

Thanks,
Johannes



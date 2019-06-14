Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683C446A4C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 22:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfFNUhS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 16:37:18 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:52218 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfFNUhR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 16:37:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbswk-00037X-P9; Fri, 14 Jun 2019 22:37:14 +0200
Message-ID: <5706f50a755ba082580483e1971ece33c42fa4da.camel@sipsolutions.net>
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Fri, 14 Jun 2019 22:37:11 +0200
In-Reply-To: <CAKR_QVLyxBdqJAN6CsVG3ts41NOED56MvWdgvgVKPm-GRJXo-g@mail.gmail.com> (sfid-20190614_222710_879124_F0A98FD0)
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
         <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
         <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
         <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
         <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
         <CAKR_QV+5oY-5z4UB+HKV_57r5NneDme+TBg_c26h4C7Sy8R+UQ@mail.gmail.com>
         <309ba2702f6b553a3dd08262efe34c4cecc4e445.camel@sipsolutions.net>
         <CAKR_QVLyxBdqJAN6CsVG3ts41NOED56MvWdgvgVKPm-GRJXo-g@mail.gmail.com>
         (sfid-20190614_222710_879124_F0A98FD0)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 22:27 +0200, Tom Psyborg wrote:
> 
> If you don't want to read posts but only topic title, in short, no
> data pass thorugh with v2/v3 of this patch. Only v1 works.

I can read what you're saying, but I cannot understand it.

This patch doesn't modify any TX/RX path in any way. It only affects
whether you can or can not create certain interfaces.

johannes


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB276779
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfGZN3Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 09:29:16 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49098 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGZN3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 09:29:16 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hr0Hb-0003p9-6F; Fri, 26 Jul 2019 15:29:15 +0200
Message-ID: <4deeee0289e706d5e594d00d987c233fb8fb25b5.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/2] nl80211: Add support for EDMG channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Date:   Fri, 26 Jul 2019 15:29:13 +0200
In-Reply-To: <1563194767-4817-2-git-send-email-ailizaro@codeaurora.org>
References: <1563194767-4817-1-git-send-email-ailizaro@codeaurora.org>
         <1563194767-4817-2-git-send-email-ailizaro@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexei,

I'm not exactly sure why, but this breaks practically all connectivity
on 2.4 and 5 GHz channels (at least in hwsim tests).

Please check and resubmit.

It'd also be good to reformat the commit log a bit, maybe adding
paragraphs, it's a bit of a "wall of text".

Thanks,
johannes


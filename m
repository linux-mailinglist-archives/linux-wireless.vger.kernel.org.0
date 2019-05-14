Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA02B1C5A4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfENJGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 05:06:05 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:40514 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 05:06:05 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hQTNr-0007KZ-MM; Tue, 14 May 2019 11:06:03 +0200
Message-ID: <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: remove warning message
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Zhi Chen <zhichen@codeaurora.org>
Date:   Tue, 14 May 2019 11:05:51 +0200
In-Reply-To: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org> (sfid-20190514_110314_752671_7E53E9A2)
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
         (sfid-20190514_110314_752671_7E53E9A2)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-05-14 at 17:01 +0800, Yibo Zhao wrote:
> In multiple SSID cases, it takes time to prepare every AP interface
> to be ready in initializing phase. If a sta already knows everything it
> needs to join one of the APs and sends authentication to the AP which
> is not fully prepared at this point of time, AP's channel context
> could be NULL. As a result, warning message occurs.
> 
Err, what was the point in sending v2 without any changes?

johannes


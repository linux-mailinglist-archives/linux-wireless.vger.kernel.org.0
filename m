Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041C05CE02
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfGBKz5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 06:55:57 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36574 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfGBKz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 06:55:57 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hiGS4-0004zF-0o; Tue, 02 Jul 2019 12:55:56 +0200
Message-ID: <24cea93e4db350e1269c41e30c4ca5c3e4d3ad0c.camel@sipsolutions.net>
Subject: Re: [PATCH] HE: STA disassociate AP due to QOS NULL not sent
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <Shay.Bar@celeno.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 02 Jul 2019 12:55:53 +0200
In-Reply-To: <20190702105019.10633-1-shay.bar@celeno.com>
References: <20190702105019.10633-1-shay.bar@celeno.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Please put "mac80211" prefix, and resend the patch without line
wrapping.

It'd probably also be good to remove the 'legal footer', not sure I
should take patches with that.

Thanks,
johannes



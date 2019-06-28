Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97C759C7C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF1NEr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 09:04:47 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50254 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF1NEr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 09:04:47 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgqYY-0001Ng-Bc; Fri, 28 Jun 2019 15:04:46 +0200
Message-ID: <0e261a8a1200a7e55e94d8260ef8cfbaf03b2bd7.camel@sipsolutions.net>
Subject: Re: [RFC V2 7/8] cfg80211: ibss: use 11a mandatory rates for 6GHz
 band operation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 28 Jun 2019 15:04:45 +0200
In-Reply-To: <1561461027-10793-8-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
         <1561461027-10793-8-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-25 at 13:10 +0200, Arend van Spriel wrote:
> The default mandatory rates, ie. when not specified by user-space, is
> determined by the band. Select 11a rateset for 6GHz band.

Hmm. Again, didn't you just say that 6 GHz didn't allow legacy rates,
and so these shouldn't be mandatory?

johannes


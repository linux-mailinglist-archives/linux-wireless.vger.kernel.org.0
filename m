Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5413AF7E8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 10:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfIKI1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 04:27:54 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33180 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfIKI1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 04:27:54 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i7xyh-0001JR-LJ; Wed, 11 Sep 2019 10:27:52 +0200
Message-ID: <566a7d7633c09e1c6fafb77c71aa0214585b407f.camel@sipsolutions.net>
Subject: Re: [PATCH 4/8] mac80211: Allow user space to register for station
 Rx authentication
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 10:27:50 +0200
In-Reply-To: <20190830112451.21655-5-luca@coelho.fi>
References: <20190830112451.21655-1-luca@coelho.fi>
         <20190830112451.21655-5-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-30 at 14:24 +0300, Luca Coelho wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> To support Pre Association Security Negotiation (PASN) while already
> associated to one AP, allow user space to register to Rx authentication
> frames, so that the user space logic would be able to receive/handle
> authentication frames from a different AP as part of PASN.
> 
> Note that it is expected that user space would intelligently register
> for Rx authentication frames, i.e., only when PASN is used and configure
> a match filter only for PASN authentication algorithm, as otherwise
> the MLME functionality of mac80211 would be broken.

This literally broke hundreds of wpa_s tests, so I guess it's not
"intelligently register[ing]" for them...

johannes


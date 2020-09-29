Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B959827BFDA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 10:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgI2Ipj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 04:45:39 -0400
Received: from sitav-80046.hsr.ch ([152.96.80.46]:33124 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2Iph (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 04:45:37 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 04:45:36 EDT
Received: from think (unknown [185.12.128.224])
        by mail.strongswan.org (Postfix) with ESMTPSA id 6A2014013B;
        Tue, 29 Sep 2020 10:36:06 +0200 (CEST)
Message-ID: <ae0faf3ed86deae5050477ff5a2ac6d14c8cb312.camel@strongswan.org>
Subject: Re: [PATCH] nl80211: reduce non-split wiphy dump size
From:   Martin Willi <martin@strongswan.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Date:   Tue, 29 Sep 2020 10:36:06 +0200
In-Reply-To: <20200928130655.53bce7873164.I71f06c9a221cd0630429a1a56eeae68a13beca61@changeid>
References: <20200928130655.53bce7873164.I71f06c9a221cd0630429a1a56eeae68a13beca61@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes,

> When wiphy dumps cannot be split, such as in events or with
> older userspace that doesn't support it, the size can today
> be too big.
> 
> Reduce it, by doing two things:

Thanks for the improved patch, works for me:

Tested-by: Martin Willi <martin@strongswan.org>


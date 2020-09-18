Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C827038D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 19:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRRww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 13:52:52 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46048 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgIRRww (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 13:52:52 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 13:52:52 EDT
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 17BE74F9D9A;
        Fri, 18 Sep 2020 17:45:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kGALAGXC8HgJ; Fri, 18 Sep 2020 17:45:29 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 7B0D24F9D98;
        Fri, 18 Sep 2020 17:45:29 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 18 Sep 2020 10:45:29 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 04/22] nl80211: correctly validate S1G beacon head
In-Reply-To: <8b7f1ab8a15a06a23b7db2fb120e3144c482d7b9.camel@sipsolutions.net>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
 <20200908190323.15814-5-thomas@adapt-ip.com>
 <8b7f1ab8a15a06a23b7db2fb120e3144c482d7b9.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <97924cf65e6806fd896ada049f3d46ea@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:56, Johannes Berg wrote:
> On Tue, 2020-09-08 at 12:03 -0700, Thomas Pedersen wrote:
>> The S1G beacon has a different header size than regular
>> beacons, so adjust the beacon head validator.
> 
> I've applied this already and will keep it, but you later add short
> beacons - don't they need further adjustments here too?

Yes, but I was planning on doing that in the (yet to be submitted) "add 
S1G
short beacon support" patch.

-- 
thomas

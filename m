Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2607A3E518E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 05:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhHJDjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 23:39:42 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:53756 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhHJDjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 23:39:42 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.135])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1E84D1A0068
        for <linux-wireless@vger.kernel.org>; Tue, 10 Aug 2021 03:39:20 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F1F384C0027
        for <linux-wireless@vger.kernel.org>; Tue, 10 Aug 2021 03:39:19 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 53CE413C2B1
        for <linux-wireless@vger.kernel.org>; Mon,  9 Aug 2021 20:39:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 53CE413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628566759;
        bh=imY1lNm5G8GUS/q6JcEIXoquPUAy6l9bqDPSMjQypgc=;
        h=To:From:Subject:Date:From;
        b=jD9hlL4+DwRdj1fJzOizB8UbjkkFWQ/4za5EZ6ZmklE/lTJuSrt6tv5Cs4O2Y4wSc
         eXxLWqD/GDyc6aEFz+qLNe7ECFWA4PiIzZRSCbs4YPe+nBQfhM88jrc7nrwdY4sysM
         sA5uMex/lhtBAwbEK68wXt4OeRbtjPkScvgZr8ZM=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: question on HE debugfs output
Organization: Candela Technologies
Message-ID: <578da3a0-f029-4e60-d4e6-34d42def62e8@candelatech.com>
Date:   Mon, 9 Aug 2021 20:39:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1628566760-7OHsPFOgfl5T
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

While poking around in things, I noticed that the
he_capa debugfs is not showing the least-common-denominator, but rather
more specifically the peer's capabilities.

This could be bugs in how I'm using this, but thought I'd ask to
see if this was on purpose or not.

Code in question looks like this.  That sta->sta.he_cap is
from the peer as far as I can tell.  The local one is obtained
from the radio/driver (and then modified a bit in some hackings
I am doing).

static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
				size_t count, loff_t *ppos)
{
	char *buf, *p;
	size_t buf_sz = PAGE_SIZE;
	struct sta_info *sta = file->private_data;
	struct ieee80211_sta_he_cap *hec = &sta->sta.he_cap;
	struct ieee80211_he_mcs_nss_supp *nss = &hec->he_mcs_nss_supp;

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

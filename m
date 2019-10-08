Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD59CFDC4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfJHPin (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 11:38:43 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36540 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPik (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 11:38:40 -0400
Received: by mail-oi1-f180.google.com with SMTP id k20so15195803oih.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cvTOYLheFd0dfZ2lmF9Eizw+BwIMNmNffCYIZFbkI1Q=;
        b=fVQQQSkY4cY6JW1YPpqb1C4IG0NaIsgGqsWYt/1Z4SVww5n0iD9nhP1wjhwgg70h6u
         eKkKMCHY4B/3/2WSRUQ3S3MkXddV5nXfat446nR967LZhzUbjwbTa1bZebG05QTAVggX
         AuUX3xzT2tPcSWvZ5Wgt6ppffXAfxi2r+ED5LEed2aHYTt75Iz/k9AN0AUl8FHSWbHcn
         0jbYTB0bFK2jToyilxgfZBc2FlxtOTwve+Jaj71haYC/70qqCuOB/R9TW1PYO+Sxx/K6
         hHOW/bii05phi5KaM6gcwbFonGHM4XdwGCje0ezkiG55sHNWq/XEbnPtAc3jbxc36k83
         /qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvTOYLheFd0dfZ2lmF9Eizw+BwIMNmNffCYIZFbkI1Q=;
        b=knGOssGvkkrtnKGacLt+ok1V7FFIqmtY9DCM+xz7FfEcen8UGr/93umJmdbLw+76wb
         m2BRsdiHsAzDI7EF8T1KiZJpqNyTRVrUrYz2XV6GtRhA8bWQCJHcQj/oiIriJ+razFMQ
         bzZkHvULCj5TT5mZHKIxpQJAVwRCIMjIZwNdkW35m6ST+/KWRkNtNZIf93KT8sV4eGlR
         CSFwqBUojNxuP84hITZ4Wvb9DATykVu80RAzjxBPmfLcNfjwPP/UOtKPaikit3cIPH4K
         SkoFv7n47wCnCrrKH4Txr5FG4fHYRwzuNM0y1k/JGxYzJ1O0pdTS6As9j146Mqi+uOyQ
         7HfA==
X-Gm-Message-State: APjAAAWMdX91zs+mDt7csSo+mHekUrjcor7FzmEjLAck3uyHvzT6BW/j
        ln7oq7BU/ISYBrUnfFWPyNscKLL3
X-Google-Smtp-Source: APXvYqyTUxrGXWSuDrey+8trLjirMYTCtnsmeCUMk67/TSDoXYwtXl+R1F1NceJ2Skk8vBtEDRgGiQ==
X-Received: by 2002:a54:4582:: with SMTP id z2mr4274060oib.53.1570549119790;
        Tue, 08 Oct 2019 08:38:39 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n4sm5737693oij.9.2019.10.08.08.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 08:38:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
References: <20190913195908.7871-1-prestwoj@gmail.com>
 <20190913195908.7871-2-prestwoj@gmail.com>
 <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
 <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
 <fa09d946e85a637d7b49e208714945dcbcc23f76.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <2cf6ce4c-e9b7-9927-0f6f-52433ab3c66b@gmail.com>
Date:   Tue, 8 Oct 2019 10:28:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fa09d946e85a637d7b49e208714945dcbcc23f76.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>>> And, I'm confused, but isn't the polarity of the scanning check
>>> wrong?
>>
>> Ah yeah, after you pointed that out I realized 'scanning' is a bit
>> field. I should be doing:
>>
>> test_bit(SCAN_HW_SCANNING, &sdata->local->scanning)
> 
> I think checking for all the bits is fine (and necessary, just HW scan
> is unlikely to be enough, changing the MAC address would also disrupt a
> software scan) - just need to invert the polarity?

I concur that scanning should be checked as
if (sdata->local->scanning).  So Johannes you're right that the polarity 
is reversed.  However, __ieee80211_start_scan seems to check for 
local->scan_req instead to take deferred scans into account.  So I 
wonder if that is a better approach.

Regards,
-Denis

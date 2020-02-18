Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1748161E69
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 02:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgBRBLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 20:11:17 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:39834 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgBRBLR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 20:11:17 -0500
Received: from [10.5.50.155] (unknown [144.139.72.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5674313C341
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2020 17:11:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5674313C341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1581988277;
        bh=eZwqhkRK0BXFU7QdyftzuMCHemJIoSPOWbtJ6MCp70Y=;
        h=Date:From:To:Subject:From;
        b=g3v+mD3rWFvUkZMGZt/RyVJ8e98cDUdgGX5ijhjAe/tHb6HeO7vReXZNRanfqRXgl
         CMQPXjyXHqY5vGbnvzx3JAR55xkqKhBdX7tAQdHugjSeR/ibWrBHx1514pzEPjpvaT
         beQigYLljgWrtmGrOJ7fsnjCWkkFgtc3hWieVG2w=
Message-ID: <5E4B39B2.8050905@candelatech.com>
Date:   Mon, 17 Feb 2020 17:11:14 -0800
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Any reason AID is not in the NL80211_STA_INFO enumeration?
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To sniff /AX stations, it is helpful to know their AID.  So, any problems
with adding it to 'iw station dump' output?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


Return-Path: <linux-wireless+bounces-5230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4788AE19
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 19:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385E31F3D4BD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F1535DB;
	Mon, 25 Mar 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="RoSNqCri"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608B74C1B
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389241; cv=none; b=b8nzgfl7k1TQ8c5rAxzd0TlOAiSCQic68ihcPlmKyX/rlCz12mVOiMs0VujPkIxtzFVIIt/7IiQTs+woOfCT09hjtw5Seh2d+rbm+TdRv3bhkPxh7VDGV0xbIEYlK+wzKwS5oxbbdb7j29CfKD1utQpPUdRioFsYJb0pSoemr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389241; c=relaxed/simple;
	bh=0u6Omls0QpV76GNc+JmKu1hV8I7hNFtufiZIFDhaIlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kSDvlMG8vhhuh7Nl3ar7iH8X+p1dQa1xc30CqcOl00EC26BbDOsnU2TDNPnUpWQMABxEQcpCGwAQvWKcZDi7bwzWPInfEtxLPOjdpp+MrNqztR5IIhk6CUIfe56ALsORukGWGyh6/JnUv6L/tJ1/wyV0OzBWBWNvpMiWnQ17pZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=RoSNqCri; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5CFADC00080;
	Mon, 25 Mar 2024 17:53:51 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6F27E13C2B0;
	Mon, 25 Mar 2024 10:53:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6F27E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711389230;
	bh=0u6Omls0QpV76GNc+JmKu1hV8I7hNFtufiZIFDhaIlQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RoSNqCri7HgWPnivklrY+wnJX/pLPMelmwQOoqKBzu89dRjcbJY8Nm+xTM6xIe+bt
	 /jixyFYliYXoswm3E38MaBHqyS+vO7M89/XdW5OW/DsYSmK+Ty7+OVMZagPB4jAoFv
	 Lz1T12cwVhjcG3FIwANwAk5WUNKox7emapyCCNJI=
Message-ID: <7b30b488-b513-e3ab-cdbf-75449d0dcdda@candelatech.com>
Date: Mon, 25 Mar 2024 10:53:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: mac80211: Ensure links are cleaned up when driver
 fails.
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <20231111001023.1335122-1-greearb@candelatech.com>
 <5fe480c4-fa39-1d29-a5e9-ba2447b08dd2@candelatech.com>
 <449f6afbc20c57f704dbeabc3a8eac8fec676405.camel@sipsolutions.net>
 <6bed94b3-4674-7fe9-ee82-bac7f9c7ffd6@candelatech.com>
 <973efc2cb87812f512fd33f354a91da17e3d8564.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <973efc2cb87812f512fd33f354a91da17e3d8564.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711389232-tsCoaV99Cc-B
X-MDID-O:
 us5;at1;1711389232;tsCoaV99Cc-B;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 3/25/24 10:43, Johannes Berg wrote:
> On Mon, 2024-03-25 at 10:40 -0700, Ben Greear wrote:
>> It is needed because if FW crashes while you are trying to remove links, then link
>> removal would fail, which causes mac80211 to not clean up its links.
> 
> OK. It should get back to some legal state after recovery though?

I assume mac80211 will re-add links on re-association/recovery.

> 
>> In case where you
>> are trying to delete the station, this causes un-cleaned links which caused crashes
>> back when I was creating this patch.  My patch allows always cleaning up the links
>> regardless of driver errors in the teardown paths.
> 
> Seems potentially more like driver errors. Or perhaps we should just
> ignore driver errors entirely?

I guess you need errors reported when building links, but maybe removal always
has to succeed.  Last I looked at iwlwifi, it returned errors on link
removal when FW crashed as it was trying to remove them.

>> Always possible some intervening changes made this less of a problem, especially since
>> MLO is disabled for be200 in upstream code anyway now.
> 
> Well that's just temporary, but we've also done a lot of work on FW
> error recovery, though likely unrelated to this particular issue.
> 
>> I can remove the extra logging if you are otherwise OK with the approach
>> but don't want the logs.
> 
> Well it'd be nice to actually see what crashed, and maybe it should
> really be driver fixes? I don't really understand why mac80211 would
> crash on failure of link removal.

6.6-ish with old be200 firmware + MLO was a bad experience.  There were multiple crashes all
over the place.  This was one of them, but I don't recall exactly how it crashed, just
something about un-deleted (or re-built) links when rest of the code expected them to be deleted since
STA was going away.

This below is the real change in the patch.  It would keep us from re-building links
in teardown paths.  Rest of the patch is passing in the knowledge of whether we can ignore
the failure or not.

@@ -325,13 +328,17 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
       }
         if (ret) {
-        /* restore config */
-        memcpy(sdata->link, old_data, sizeof(old_data));
-        memcpy(sdata->vif.link_conf, old, sizeof(old));
-        ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
-        /* and free (only) the newly allocated links */
-        memset(to_free, 0, sizeof(links));
-        goto free;
+        sdata_info(sdata, "driver error applying links: %d  Restoring old configuration, old_links: 0x%x  dormant_links: 0x%x requested new_links: 0x%x 
ignore-driver-failures: %d\n",
+               ret, old_links, dormant_links, new_links, ignore_driver_failures);
+        if (!ignore_driver_failures) {
+            /* restore config */
+            memcpy(sdata->link, old_data, sizeof(old_data));
+            memcpy(sdata->vif.link_conf, old, sizeof(old));
+            ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
+            /* and free (only) the newly allocated links */
+            memset(to_free, 0, sizeof(links));
+            goto free;
+        }
       }

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com




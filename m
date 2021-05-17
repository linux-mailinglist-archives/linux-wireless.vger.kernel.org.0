Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB74383CC0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhEQS4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 14:56:02 -0400
Received: from dispatchb-us1.ppe-hosted.com ([67.231.154.165]:57824 "EHLO
        dispatchb-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237328AbhEQS4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 14:56:01 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.179])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B0AA91A0063;
        Mon, 17 May 2021 18:54:43 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 61542AC007D;
        Mon, 17 May 2021 18:54:43 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1818113C2B1;
        Mon, 17 May 2021 11:54:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1818113C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1621277682;
        bh=VclJtQSF+jUZ3F7AVrDv1d4cZ34uD47bReY93FbufZI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=cShp1qdoRcpxy7MkcDhgQs4PwOC0gyYUjOxilszkPJN/YioNYdhTADw4xEn1x9Prs
         avNhUtB9ahqb14FCprCCgkpPCiCbpOFgbeOC7YSy2rT+Lef+/WE9NcZHbwFx1mvbe2
         mP7XXKH//aFpIgrSmQVV7DjpkubuWsSDLxnwWdbA=
Subject: Re: [PATCH 00/18] mac80211/driver security fixes
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20210511180259.159598-1-johannes@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <704e1c77-6c48-79f7-043a-b2d03fbfef8b@candelatech.com>
Date:   Mon, 17 May 2021 11:54:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511180259.159598-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1621277684-dLPKrEuobSvn
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/11/21 11:02 AM, Johannes Berg wrote:
> Several security issues in the 802.11 implementations were found by
> Mathy Vanhoef (New York University Abu Dhabi), who has published all
> the details at
> 
> 	https://papers.mathyvanhoef.com/usenix2021.pdf

Is anyone backporting this to 4.19 and other 'stable' kernels?

For anyone using ath10k-ct driver, I have initial update of the
driver done for 4.19 (owrt uses this), but cannot compile against
the 4.19 kernel unless the mac80211 changes are also backported.

In interest of not duplicating effort...I was hoping these would
just show up in the 4.19 stable sometime soon...

Thanks,
Ben

> 
> 
> Specifically, the following CVEs were assigned:
> 
>   * CVE-2020-24586 - Fragmentation cache not cleared on reconnection
>   * CVE-2020-24587 - Reassembling fragments encrypted under different
>                      keys
>   * CVE-2020-24588 - Accepting non-SPP A-MSDU frames, which leads to
>                      payload being parsed as an L2 frame under an
>                      A-MSDU bit toggling attack
>   * CVE-2020-26139 - Forwarding EAPOL from unauthenticated sender
>   * CVE-2020-26140 - Accepting plaintext data frames in protected
>                      networks
>   * CVE-2020-26141 - Not verifying TKIP MIC of fragmented frames
>   * CVE-2020-26142 - Processing fragmented frames as full frames
>   * CVE-2020-26143 - Accepting fragmented plaintext frames in
>                      protected networks
>   * CVE-2020-26144 - Always accepting unencrypted A-MSDU frames that
>                      start with RFC1042 header with EAPOL ethertype
>   * CVE-2020-26145 - Accepting plaintext broadcast fragments as full
>                      frames
>   * CVE-2020-26146 - Reassembling encrypted fragments with non-consecutive
>                      packet numbers
>   * CVE-2020-26147 - Reassembling mixed encrypted/plaintext fragments
> 
> 
> In general, the scope of these attacks is that they may allow an
> attacker to
>   * inject L2 frames that they can more or less control (depending on the
>     vulnerability and attack method) into an otherwise protected network;
>   * exfiltrate (some) network data under certain conditions, this is
>     specific to the fragmentation issues.
> 
> 
> A subset of these issues is known to apply to the Linux IEEE 802.11
> implementation (mac80211). Where it is affected, the attached patches
> fix the issues, even if not all of them reference the exact CVE IDs.
> 
> In addition, driver and/or firmware updates may be necessary, as well
> as potentially more fixes to mac80211, depending on how drivers are
> using it.
> 
> Specifically, for Intel devices, firmware needs to be updated to the
> most recently released versions (which was done without any reference
> to the security issues) to address some of the vulnerabilities.
> 
> To have a single set of patches, I'm also including patches for the
> ath10k and ath11k drivers here.
> 
> We currently don't have information about how other drivers are, if
> at all, affected.
> 
> johannes
> 
> 
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

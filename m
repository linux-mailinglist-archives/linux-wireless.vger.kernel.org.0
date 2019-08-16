Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6E8FEB7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfHPJKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 05:10:40 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17517 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfHPJKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 05:10:40 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 05:10:39 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1565945734; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=aawkqy3/T+ww5h9tpWYRXKNJO6uzjcl5PpZ/ScBEEcRXF3ilvRHywZHbMz1iiDkEPOnnjFUB299eCP4sMUH6YXywkB+gveH4aW1nQddd4QGRCsN9c7zHOjWg5uhS1MQZER6aTpIte3wvzEEmwWF0izXIggShvl6KAUKMdS8seWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565945734; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=P686FzoH40wgnddMIMAu37CGrgXXQfgN5pjXU3pr9lw=; 
        b=G/yaMM6xZHAAedqPGpdSOlx4lUMkLXYqGTKEbH0zWtO5ZRLYs2NdtigNMdWrLfPwuU1ZGQpDyIOWumG9ANwjMZZRWtFi3uDdrPGpvFETya2eXlpehC+eMiM/fRjZs4Ea2zypvq4DHxWVBsoCOX42BbribMAVtLTTi3+jR1W11rY=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=in04.sg;
        spf=pass  smtp.mailfrom=angelsl@in04.sg;
        dmarc=pass header.from=<angelsl@in04.sg> header.from=<angelsl@in04.sg>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1565945734;
        s=zoho; d=in04.sg; i=angelsl@in04.sg;
        h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=918; bh=P686FzoH40wgnddMIMAu37CGrgXXQfgN5pjXU3pr9lw=;
        b=K0imBB80HR7Sa1qlOWOf+3y5Ev+xLyf48kMPodGF93VpiHF+fxG4YgvZ4IbC2eLi
        pCOjOhfyM7B3kpi5M7lOgfCc7yNINgXfgF64PWAumxtY2tz8VJFf128sNk4lvlWU45n
        /JDvXxenJjlrfn/cQYkHwlLnmwPH1ibHVWmoBPTc=
Received: from [172.17.137.94] (137.132.216.39 [137.132.216.39]) by mx.zohomail.com
        with SMTPS id 1565945732712882.5414306157879; Fri, 16 Aug 2019 01:55:32 -0700 (PDT)
To:     Ilan Peer <ilan.peer@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
From:   Tee Hao Wei <angelsl@in04.sg>
Subject: iwlwifi: 9260: Spurious "Unhandled alg: 0x707" and 0x71b
Message-ID: <badc218b-ea1f-3697-b1f2-3ebb294d9849@in04.sg>
Date:   Fri, 16 Aug 2019 16:55:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've been getting "Unhandled alg: 0x707" or 0x71b randomly
on my Intel 9260. It seems to happen most often when it
associates to a new AP (or roams to a different one that
has the same SSID/authentication). It also seems to happen
only with particular APs. (I don't have access to the APs,
so there's not much I know about them.)

I applied the two patches mentioned in Bugzilla #203593[1]
i.e. "iwlwifi: mvm: Allow multicast data frames only when
associated" and "iwlwifi: mvm: Allow multicast data frames
only when authorized" on top of iwlwifi in 5.2.8, which
improved the situation a lot, but it still happens pretty
frequently.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=203593

I'll try to collect some debug data soon. Also, I'll try
to see if my 8260 has the same issues.

Is there anything else I should try or any other patches I
should backport?

Thanks.

-- 
Hao Wei


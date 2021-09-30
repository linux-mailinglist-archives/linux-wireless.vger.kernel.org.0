Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4564841D86E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350309AbhI3LLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 07:11:02 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58461 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350266AbhI3LLB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 07:11:01 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BA2645C0189
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 07:09:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 Sep 2021 07:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nowhere.ws; h=
        message-id:date:mime-version:to:from:subject:content-type
        :content-transfer-encoding; s=fm3; bh=msR4eh2uQRa/b108nOT/Xd6DG5
        s5N+ICv2WL58DdTxI=; b=JLMm3+iw0zNSANfsNKeSzWQLlVspdp+42BxPg0gjcH
        /ckQkQltPGR1KfpDXHvZlgTcZPtBOAh56tSQw01Yjds100ni9OYqo56D5rJXAcz7
        WcRJa4+FmZ1YgXb8YpQRY5eJsHe2KNLJ8uJZ+jHm5Cy0oNGEsFBBs5IZ/cn1AHlo
        76r7vCh3hhjwCi7n2Ll4TT7VbymvAs03xN8CqsaGZ4bH7epnqTRHvs6k1QvZuIfH
        Km0tcOdxIL6JuF53nl+yN0PsOWHfESrb11Bgo30HpCuOosK5Na2VXOTwIX4wZVXU
        w29k13tvjo96D/YbGmHQcR4MdeUWaXRfI0joO4wL6NNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=msR4eh
        2uQRa/b108nOT/Xd6DG5s5N+ICv2WL58DdTxI=; b=JVco8ZxWA6iVicC4b9kSWn
        lK5vs/RrXDBWpEn927ICQI4wELdSkrUc6qvgsGguTTeijzMz+KYf87Ec8NydqfpY
        ZD5Tr5pfAGJnMbXO99wrqYzpUk7Y0zZ2vYuIlzkPoQe/fdXdnc35YyV3ylxlJ5wq
        aAhWZtk1RATLOzwcZdOJ9Fa+cI2NFzuFGip4hcYVqOemmTOV+9kQ/ZOmB9jGWusO
        a1On/9RMhQWHvJWhNBcNAKxm6WMWkBBpLIWl0ixS/pcwtAvCt2fN+IYNpxvvCJRf
        lqOUJDPufdwFQ2Wq9rUQ4tuBBSt3qPHTNgRD+x0WLj1q2lmtCpIjBOTjk4pm5Ynw
        ==
X-ME-Sender: <xms:3ppVYaG35Ysv3m2CYMU58YyEDzZCPceiKxZ-fzzUhucJjiu4jl1yYQ>
    <xme:3ppVYbXxKyL9rU2zBwplNKSywIfeWrPmxy7Ki5THwQhl6uMMR0FoyNrLIQC0NmiJJ
    BDq9P36lH3DlogWjtE>
X-ME-Received: <xmr:3ppVYULgGsjpOWxOpjzZJ8i8VDF7NLzdZrTow47-zQTPEtQ9uhFeNO7Yuj3xCSD_YVTd-smfpW1P7OqIii4kEyhHHJrer7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlgedtmdenucfjughrpefkff
    ggfgfvhffutgfgsehtjeertddtfeejnecuhfhrohhmpeevhhhrihhsthhirghnucfhrhgr
    nhhkvgcuoehnohgsohguhiesnhhofihhvghrvgdrfihsqeenucggtffrrghtthgvrhhnpe
    fhteegvdekjedtueevgeeuueejvdevhfelfedvgfettdegjeeileeiveejgeefvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnohgsohguhi
    esnhhofihhvghrvgdrfihs
X-ME-Proxy: <xmx:3ppVYUE0qJbXuD3oWkxeC4EA-k21--j4eZAB6E0n-o4Ej2M-zxt8xg>
    <xmx:3ppVYQVqwAotzG9aJdTn7wSekk-qQODB_FWP5C2TQvam7D6i6_42aA>
    <xmx:3ppVYXM-sAbNDBL60Fkfm3vkpQmE2pfVbCI3x547G6XkGOUo5MnPMA>
    <xmx:3ppVYTDGtnwPIcmAsYfNSuWrIo1R60CW9P94VkoxTgj_a7Z3U4braQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 07:09:18 -0400 (EDT)
Message-ID: <5d221757-372e-fd07-694a-b7207f448e67@nowhere.ws>
Date:   Thu, 30 Sep 2021 13:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US-large
To:     linux-wireless@vger.kernel.org
From:   Christian Franke <nobody@nowhere.ws>
Subject: mt76: MT7612E dropouts on Ruckus R650
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

we recently upgraded our office network to a Ruckus R650.

With my MT7612E card, I frequently have dropouts on this new ap, they 
all look something like this:

64 bytes from 192.168.14.1: icmp_seq=237 ttl=64 time=1.35 ms
64 bytes from 192.168.14.1: icmp_seq=238 ttl=64 time=1.48 ms
64 bytes from 192.168.14.1: icmp_seq=239 ttl=64 time=4.60 ms
64 bytes from 192.168.14.1: icmp_seq=241 ttl=64 time=1752 ms
64 bytes from 192.168.14.1: icmp_seq=248 ttl=64 time=542 ms
64 bytes from 192.168.14.1: icmp_seq=249 ttl=64 time=1.07 ms

Whenever this happens, the following shows up in the kernel log:

<6>[32244.957969] mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
<6>[32244.957984] mt76x2e 0000:02:00.0: Build: 1
<6>[32244.957989] mt76x2e 0000:02:00.0: Build Time: 201507311614____
<6>[32244.980544] mt76x2e 0000:02:00.0: Firmware running!
<6>[32244.981660] ieee80211 phy0: Hardware restart was requested

This is happening with distro kernel 5.14.7-arch1-1 on x86_64.

I would be glad to investigate this further, however I don't know how to 
best approach this.

Any suggestions? :)

Thank you,
Chris

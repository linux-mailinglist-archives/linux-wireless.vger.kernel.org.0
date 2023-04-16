Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5ED6E388B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDPNNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDPNNp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 09:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41404211B
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 06:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A14619E4
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 13:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F329C433EF;
        Sun, 16 Apr 2023 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681650816;
        bh=Hv8eudMtXGgOxhIT1Cq3LG4BJ96JJeFHXsL8KtcptdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2/UsQGlhyrKOvpiVYJesW08nFlnRRMhyuzXcTJ9teJXtM2taS9yCchYYeh8ufoHA
         QvCmLDn/ve3dHlqqurqgARg/VDxFn47unBQl1OC4ZoUyoj5tAe8tHml/iBlraOFj/d
         Qu2hMoFMvkDYNMRla7fIJIlTDv4gx/+I/OKYYP+ZA/qd8DfR1Sp3OJwm9f1OnFBKn/
         vnseQgA67bojjp52DVl6LPTwMAN6KAmKMVK3lC84qZ6JRTxvzZw7UaTiBbLpcOlEIX
         Hhv8poAtpZWDP8+MtMtcp1fA1zHgCcpJWsYc2gEOqs257jA7PINQHkR/CBHWrZOXw5
         EZDjsC7HkHQUg==
Date:   Sun, 16 Apr 2023 08:13:34 -0500
From:   "sforshee@kernel.org" <sforshee@kernel.org>
To:     Eric Sellman <GAK_ACTION@live.com>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: wireless-regdb: Update regulatory rules for Canada on 5GHz
Message-ID: <ZDv0fuvSK0x/I4ci@ubuntu-x1>
References: <SJ0PR22MB249501047C8F6F51CCB9D06A8F8C9@SJ0PR22MB2495.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR22MB249501047C8F6F51CCB9D06A8F8C9@SJ0PR22MB2495.namprd22.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Apr 01, 2023 at 08:26:51AM +0000, Eric Sellman wrote:
> My apologies but I have made a mistake.
> 
> My previous submission about Canada is invalid. The weather frequency range has already been avoided.
> 
> Here is the correct information I meant to share with you.
> 
> https://www.ic.gc.ca/eic/site/smt-gst.nsf/eng/sf10971.html#s6
> 
> "Devices with occupied bandwidths which overlap different bands shall comply with all operational requirements for each band."
> 
> https://semfionetworks.com/blog/5ghz-regulations-in-canada-2018-update/
> 
> Canada still permits the lower 5ghz frequencies to be used for VHT 160. But it's missing according to the information for the Canadian profile in line 326

Just for the record, as we discussed for the US rules, we can't set the
max bandwidth for a range to a value larger than the range itself or the
kernel will reject the database. However, it looks like with AUTO_BW the
kernel will allow larger bandwidths with adjacent channels.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt#n326.
> 
> And I wanted to mention that for 5150 - 5250 on line 328, the transmit power has been increased to 1 watt or "30 dBm" according to this document here.
> 
> https://www.ic.gc.ca/eic/site/smt-gst.nsf/eng/sf11294.html

I see a limit of 200 mW for 5150-5250 MHz. If I'm missing it, can you
please tell me which section specifies a max EIRP of 30 dBm?

Thanks,
Seth

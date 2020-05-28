Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF341E5925
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgE1Hm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgE1Hm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 03:42:57 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 May 2020 00:42:56 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8558C05BD1E;
        Thu, 28 May 2020 00:42:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeDBk-004iTR-Oi; Thu, 28 May 2020 09:42:52 +0200
Message-ID: <af656620aee6768414fbef63beddf5f04851e5e8.camel@sipsolutions.net>
Subject: Re: [PATCH v3 01/11] cfg80211: use only HE capability to set
 prohibited flags in 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Vamsi Krishna <vamsin@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org
Date:   Thu, 28 May 2020 09:42:51 +0200
In-Reply-To: <6a606d4e32d6eb00b33f5ce8ad44a71994640c7d.camel@sipsolutions.net> (sfid-20200528_094155_221294_8CFB7C6D)
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <7f2a2a382c42b7285b9ad1eeac4e8060bc8d897a.camel@sipsolutions.net>
         <0fa1c07811796add4a6a23c81cbafe41@codeaurora.org>
         <6a606d4e32d6eb00b33f5ce8ad44a71994640c7d.camel@sipsolutions.net>
         (sfid-20200528_094155_221294_8CFB7C6D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello brain, meet fingers, they're a bit slower ...

> > > 
> > IIUC the same bits are applicable for both 5 GHz & 6 GHz. I understand 
> > the macro doesn't capture both.
> 
> Yeah, I think you're right. I looked at D6.0 (though there seems to be
> D6.1?) but I couldn't quite 

... couldn't fully understand it in the limited time I had left
yesterday :)

johannes


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAC3C28F1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jul 2021 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGISTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jul 2021 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGISTo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jul 2021 14:19:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B271DC0613DD
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6FMwpt1rxA9FMdyqsXd2i7x6BCSCSYxSoe+CO80ztdw=;
        t=1625854620; x=1627064220; b=RET0XtOePb7Nk80ZtzBxOjigsCYvZ6fwwVPEIvOojgewNUm
        GelSvii7HxqHcTXZDfKcmr376Kwrirr7LVJC1kOfYhjC1jR1xcVvMXLFwxdXCr+Gwi72zsc7rNI8F
        M9BjM8O9r95Ft8FiMlJVK8cWCG5rN2yA7zyUgnM/62990WIgVHF26asVXKQxAitbMRfe4n3UKWvhj
        mzsNXZNAyCUU9XkoiyOOjKtZKtC5wI+G+XQePVGgQ7Y8C8xX+p4nAbT8yMvdS2SwfCMrP0HKet60x
        qwJkVRMSCyPG4uieD4NgYN/wZ/4SPBsy4Ye4S0gIXL8u70cenRy7KnTC0IrgoCuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m1v3T-0001Av-R2; Fri, 09 Jul 2021 20:16:51 +0200
Message-ID: <310161353e627903f2a828ac28c69ae49b81568b.camel@sipsolutions.net>
Subject: Re: [PATCH 07/24] rtw89: add MAC files
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Fri, 09 Jul 2021 20:16:50 +0200
In-Reply-To: <20210709173817.GB2099@pengutronix.de>
References: <20210618064625.14131-1-pkshih@realtek.com>
         <20210618064625.14131-8-pkshih@realtek.com>
         <20210709173817.GB2099@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-07-09 at 19:38 +0200, Oleksij Rempel wrote:
> On Fri, Jun 18, 2021 at 02:46:08PM +0800, Ping-Ke Shih wrote:
> 
> > [thousands of quoted lines]

FWIW, it would really help if you were to actually quote only the bits
you're replying to...

johannes


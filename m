Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEABD153753
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 19:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgBESOv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 13:14:51 -0500
Received: from nbd.name ([46.4.11.11]:60222 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgBESOu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 13:14:50 -0500
Received: from [149.233.176.109] (helo=[10.255.231.27])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1izPCK-0000aK-FG; Wed, 05 Feb 2020 19:14:48 +0100
Subject: Re: [PATCH 1/2] ath11k: add thermal cooling device support
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1580860830-12696-1-git-send-email-pradeepc@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <73391f93-a2c1-80b3-b77c-63c559f34326@phrozen.org>
Date:   Wed, 5 Feb 2020 19:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1580860830-12696-1-git-send-email-pradeepc@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Pradeep

1) do you plan to add the OF part so that we can run thermal_zones on 
top of this ?

2) what is the maximum number of levels that the HW supports ? looking 
at thermaltool it has to be at least 4 i guess ?
> +#define THERMAL_LEVELS  1

	John

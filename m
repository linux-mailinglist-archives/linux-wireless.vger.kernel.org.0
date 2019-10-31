Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35016EB039
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 13:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfJaM27 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 08:28:59 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53532 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaM27 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 08:28:59 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iQ9ZR-0002Hn-OM; Thu, 31 Oct 2019 13:28:57 +0100
Message-ID: <f17456e82a5fd9c83e28a186fc0c31e280a45797.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] add Wide Band Scan support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 31 Oct 2019 13:28:55 +0100
In-Reply-To: <1572524867-26703-1-git-send-email-murugana@codeaurora.org>
References: <1572524867-26703-1-git-send-email-murugana@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-10-31 at 17:57 +0530, Sathishkumar Muruganandam wrote:
> Wide Band Scan allows to perform off-channel scan on requested channel/
> frequency along with corresponding phy mode/bandwidth (40Mhz, 80Mhz).

Please document what this is for ...

johannes


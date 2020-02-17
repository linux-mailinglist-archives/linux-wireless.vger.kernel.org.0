Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F8161477
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 15:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgBQOX3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 09:23:29 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:50010 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgBQOX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 09:23:29 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j3hIx-003EBO-6i; Mon, 17 Feb 2020 15:23:23 +0100
Message-ID: <06100182506e35438e31990a56a2668a6de31735.camel@sipsolutions.net>
Subject: Re: [RFC 0/2] add 802.11 decapsulation offload support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 17 Feb 2020 15:23:22 +0100
In-Reply-To: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org> (sfid-20200217_132517_718887_22B874B1)
References: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org>
         (sfid-20200217_132517_718887_22B874B1)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-17 at 17:54 +0530, Manikanta Pubbisetty wrote:
> Adding support for offloading 802.11 decapsulation to the HW.
> This reduces the CPU cycles spent on host CPU for doing the 
> conversion from 802.11 format to ethernet format and thereby
> improving the performance of the device.

Would be nice to quantify that :)

johannes


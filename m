Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757846F7DE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 01:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhLJAMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 19:12:46 -0500
Received: from relay027.a.hostedemail.com ([64.99.140.27]:39788 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229723AbhLJAMp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 19:12:45 -0500
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 0C95B807F8;
        Fri, 10 Dec 2021 00:09:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 4CA472F;
        Fri, 10 Dec 2021 00:09:05 +0000 (UTC)
Message-ID: <4446ca5bf0a8120a37f89cdb0f50d898636630a2.camel@perches.com>
Subject: Re: [PATCH 1/2] ath11k: add dbring debug support
From:   Joe Perches <joe@perches.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 09 Dec 2021 16:09:04 -0800
In-Reply-To: <1636439522-14509-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1636439522-14509-1-git-send-email-quic_vnaralas@quicinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4CA472F
X-Spam-Status: No, score=-4.11
X-Stat-Signature: cwg8qj6swyif77ag6yqpc5cjdeyzoa7p
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Kw86AOTeybW33uD29/bmbVIk9l8MkLzg=
X-HE-Tag: 1639094945-176582
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-11-09 at 12:02 +0530, Venkateswara Naralasetty wrote:
> Target copies spectral report and CFR report through dbring to
> host for further processing. This mechanism involves ring and
> buffer management in the Host, FW, and uCode, where improper
> tail pointer update issues are seen.
> 
> This dbring debug support help to debug such issues by tracking
> head and tail pointer movement along with the timestamp at which
> each buffer is received and replenished.

> @@ -1068,6 +1107,166 @@ static const struct file_operations fops_simulate_radar = {
>  	.open = simple_open
>  };
>  
> +static ssize_t ath11k_dbr_dump_debug_entries(struct file *file,
> +					     char __user *user_buf,
> +					     size_t count, loff_t *ppos)
> +{
> +	struct ath11k_db_ring_debug *db_ring_debug = file->private_data;
> +	static const char * const event_id_to_string[] = {"empty", "Rx", "Replenish"};
> +	int size = ATH11K_DBR_DEBUG_ENTRIES_MAX * 100;
> +	char *buf;
> +	int i, ret;
> +	int len = 0;
> +
> +	buf = kzalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	len += scnprintf(buf + len, size - len, "------------------------------------\n");
> +	len += scnprintf(buf + len, size - len, "| idx | hp | tp | timestamp | event|\n");
> +	len += scnprintf(buf + len, size - len, "------------------------------------\n");
> +
> +	spin_lock_bh(&db_ring_debug->lock);
> +
> +	for (i = 0; i < db_ring_debug->num_ring_debug_entries; i++) {
> +		len += scnprintf(buf + len, size - len,
> +				 "|%4u|%8u|%8u|%11llu|%8s|\n", i,
> +				 db_ring_debug->entries[i].hp,
> +				 db_ring_debug->entries[i].tp,
> +				 db_ring_debug->entries[i].timestamp,
> +				 event_id_to_string[db_ring_debug->entries[i].event]);
> +	}

I think this would look a lot nicer column aligned along the | boundaries

	len += scnprintf(buf + len, size - len, "--------------------------------------------------------\n");
	len += scnprintf(buf + len, size - len, "|  idx |    hp    |    tp    |  timestamp  |   event   |\n");
	len += scnprintf(buf + len, size - len, "--------------------------------------------------------\n");

	spin_lock_bh(&db_ring_debug->lock);

	for (i = 0; i < db_ring_debug->num_ring_debug_entries; i++) {
		len += scnprintf(buf + len, size - len,
				 "| %4u | %8u | %8u | %11llu | %-9s |\n", i,
				 db_ring_debug->entries[i].hp,
				 db_ring_debug->entries[i].tp,
				 db_ring_debug->entries[i].timestamp,
				 event_id_to_string[db_ring_debug->entries[i].event]);



Return-Path: <linux-wireless+bounces-29341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210DC85AC7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8D324EBAC8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC0326949;
	Tue, 25 Nov 2025 15:04:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A332549B
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083048; cv=none; b=nZPPBxIXrPpZUIk+dZG6GnN2SlTUpyc8ODAAraIRQ8SBQsFqbOGUQo56w4JHucum9ovRBDd4D0/14WNrj/dGoZzFnQ/RgKXED84XO3UQMxEQLtUTYhYKEDUfuGLUFQDoEaSg/8U9e3cGp/Nq/poZsb8fJR5TvhLeSpcBkYwvAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083048; c=relaxed/simple;
	bh=T39eEVoWk/8Knzyzg7RNdKnNBpSHrK5q19TKCv4sIew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knKSYxwIhAmWlOdVltUANFjuuqTgGI5EifXBjAs0VSKugcwGcNQYqiEUYC3oiai0IWbWQAPwJjTsHSYhveQVX2JsMJZB8bHLoJ02By9I0jQ+j1bDMcuNGlSzbXTxaJAizHJIo4Ty5ipByTqmQVj0QXq/Y1i6ohIOGjC8zIrNC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1vNuaI-0008J6-R8; Tue, 25 Nov 2025 16:04:02 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1vNuaI-002Q34-0b;
	Tue, 25 Nov 2025 16:04:02 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1vNuaI-005uxX-09;
	Tue, 25 Nov 2025 16:04:02 +0100
Date: Tue, 25 Nov 2025 16:04:01 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 12/22] wifi: nxpwifi: introduce command and event
 handling infrastructure#
Message-ID: <aSXFYfWo3fade3Dg@pengutronix.de>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
 <20251117110046.2810811-13-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117110046.2810811-13-jeff.chen_1@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Jeff,

On Mon, Nov 17, 2025 at 07:00:36PM +0800, Jeff Chen wrote:
 +/* This function handles the command response.
> + *
> + * After processing, the function cleans the command node and puts
> + * it back to the command free queue.
> + */
> +int nxpwifi_process_cmdresp(struct nxpwifi_adapter *adapter)
> +{
> +	struct host_cmd_ds_command *resp;
> +	struct nxpwifi_private *priv =
> +		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
> +	int ret = 0;
> +	u16 orig_cmdresp_no;
> +	u16 cmdresp_no;
> +	u16 cmdresp_result;
> +
> +	if (!adapter->curr_cmd || !adapter->curr_cmd->resp_skb) {
> +		resp = (struct host_cmd_ds_command *)adapter->upld_buf;
> +		nxpwifi_dbg(adapter, ERROR,
> +			    "CMD_RESP: NULL curr_cmd, %#x\n",
> +			    le16_to_cpu(resp->command));
> +		return -EINVAL;
> +	}
> +
> +	resp = (struct host_cmd_ds_command *)adapter->curr_cmd->resp_skb->data;
> +	orig_cmdresp_no = le16_to_cpu(resp->command);
> +	cmdresp_no = (orig_cmdresp_no & HOST_CMD_ID_MASK);
> +
> +	if (adapter->curr_cmd->cmd_no != cmdresp_no) {
> +		nxpwifi_dbg(adapter, ERROR,
> +			    "cmdresp error: cmd=0x%x cmd_resp=0x%x\n",
> +			    adapter->curr_cmd->cmd_no, cmdresp_no);
> +		return -EINVAL;
> +	}
> +	/* Now we got response from FW, cancel the command timer */
> +	timer_delete_sync(&adapter->cmd_timer);
> +	clear_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags);
> +
> +	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
> +		/* Copy original response back to response buffer */
> +		struct nxpwifi_ds_misc_cmd *hostcmd;
> +		u16 size = le16_to_cpu(resp->size);
> +
> +		nxpwifi_dbg(adapter, INFO,
> +			    "info: host cmd resp size = %d\n", size);
> +		size = min_t(u16, size, NXPWIFI_SIZE_OF_CMD_BUFFER);
> +		if (adapter->curr_cmd->data_buf) {
> +			hostcmd = adapter->curr_cmd->data_buf;
> +			hostcmd->len = size;
> +			memcpy(hostcmd->cmd, resp, size);
> +		}
> +	}
> +
> +	/* Get BSS number and corresponding priv */
> +	priv = nxpwifi_get_priv_by_id
> +	       (adapter, HOST_GET_BSS_NO(le16_to_cpu(resp->seq_num)),
> +		HOST_GET_BSS_TYPE(le16_to_cpu(resp->seq_num)));
> +	if (!priv)
> +		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
> +	/* Clear RET_BIT from HOST */
> +	resp->command = cpu_to_le16(orig_cmdresp_no & HOST_CMD_ID_MASK);
> +
> +	cmdresp_no = le16_to_cpu(resp->command);
> +	cmdresp_result = le16_to_cpu(resp->result);
> +
> +	/* Save the last command response to debug log */
> +	adapter->dbg.last_cmd_resp_index =
> +			(adapter->dbg.last_cmd_resp_index + 1) % DBG_CMD_NUM;
> +	adapter->dbg.last_cmd_resp_id[adapter->dbg.last_cmd_resp_index] =
> +								orig_cmdresp_no;
> +
> +	nxpwifi_dbg(adapter, CMD,
> +		    "cmd: CMD_RESP: 0x%x, result %d, len %d, seqno 0x%x\n",
> +		    orig_cmdresp_no, cmdresp_result,
> +		    le16_to_cpu(resp->size), le16_to_cpu(resp->seq_num));
> +	nxpwifi_dbg_dump(adapter, CMD_D, "CMD_RESP buffer:", resp,
> +			 le16_to_cpu(resp->size));
> +
> +	if (!(orig_cmdresp_no & HOST_RET_BIT)) {
> +		nxpwifi_dbg(adapter, ERROR, "CMD_RESP: invalid cmd resp\n");
> +		if (adapter->curr_cmd->wait_q_enabled)
> +			adapter->cmd_wait_q.status = -1;
> +
> +		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
> +		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
> +		adapter->curr_cmd = NULL;
> +		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
> +		return -EINVAL;
> +	}
> +
> +	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
> +		adapter->curr_cmd->cmd_flag &= ~CMD_F_HOSTCMD;
> +		if (cmdresp_result == HOST_RESULT_OK &&
> +		    cmdresp_no == HOST_CMD_802_11_HS_CFG_ENH)
> +			ret = nxpwifi_ret_802_11_hs_cfg(priv, resp);
> +	} else {
> +		if (resp->result != HOST_RESULT_OK) {
> +			nxpwifi_process_cmdresp_error(priv, resp);
> +			return -EFAULT;
> +		}
> +		if (adapter->curr_cmd->cmd_resp) {
> +			void *data_buf = adapter->curr_cmd->data_buf;
> +
> +			ret = adapter->curr_cmd->cmd_resp(priv, resp,
> +							  cmdresp_no,
> +							  data_buf);
> +		}
> +	}
> +
> +	/* Check init command response */
> +	if (adapter->hw_status == NXPWIFI_HW_STATUS_INITIALIZING) {
> +		if (ret) {
> +			nxpwifi_dbg(adapter, ERROR,
> +				    "%s: cmd %#x failed during\t"
> +				    "initialization\n", __func__, cmdresp_no);
> +			nxpwifi_init_fw_complete(adapter);
> +			return ret;
> +		} else if (adapter->last_init_cmd == cmdresp_no) {
> +			adapter->hw_status = NXPWIFI_HW_STATUS_INIT_DONE;
> +		}
> +	}

If this driver now goes upstream could you have a look at the cleanup
patches I sent for the mwifiex driver and see which ones apply here as
well?

At least this asynchronous initialization seems entirely unnecessary,
see:

https://lore.kernel.org/all/20241202-mwifiex-cleanup-1-v3-12-317a6ce0dd5b@pengutronix.de/

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

